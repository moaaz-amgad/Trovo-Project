package com.example.trovo_app

import android.app.AppOpsManager
import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Process
import android.provider.Settings
import android.text.format.DateUtils
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date
import java.util.Locale

class MainActivity : FlutterActivity() {
	private val channelName = "trovo_app/phone_usage"

	override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
		super.configureFlutterEngine(flutterEngine)

		MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
			.setMethodCallHandler { call, result ->
				when (call.method) {
					"hasUsageAccess" -> result.success(hasUsageAccess())
					"openUsageAccessSettings" -> {
						openUsageAccessSettings()
						result.success(true)
					}
					"fetchUsageData" -> result.success(fetchUsageData())
					else -> result.notImplemented()
				}
			}
	}

	private fun hasUsageAccess(): Boolean {
		val appOps = getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
		val mode = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
			appOps.unsafeCheckOpNoThrow(
				AppOpsManager.OPSTR_GET_USAGE_STATS,
				Process.myUid(),
				packageName,
			)
		} else {
			@Suppress("DEPRECATION")
			appOps.checkOpNoThrow(
				AppOpsManager.OPSTR_GET_USAGE_STATS,
				Process.myUid(),
				packageName,
			)
		}
		return mode == AppOpsManager.MODE_ALLOWED
	}

	private fun openUsageAccessSettings() {
		val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
		intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
		startActivity(intent)
	}

	private fun fetchUsageData(): Map<String, Any> {
		if (!hasUsageAccess()) {
			return mapOf(
				"is_available" to false,
				"message" to "Usage access is not granted.",
				"collected_at" to isoNowString(),
			)
		}

		val usageStatsManager =
			getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
		val now = System.currentTimeMillis()
		val start24h = now - DateUtils.DAY_IN_MILLIS
		val bedWindow = buildBedtimeWindow(now)
		val bedStart = bedWindow.first
		val bedEnd = bedWindow.second

		// ── Use queryEvents for ALL calculations (eliminates double-counting) ──
		val start7d = now - DateUtils.DAY_IN_MILLIS * 7
		val events = usageStatsManager.queryEvents(start7d, now)
		val lastForeground = mutableMapOf<String, Long>()

		// Daily usage (last 24h only) — calculated from events, not stats
		var dailyUsageMs = 0L
		val appsUsedToday = mutableSetOf<String>()
		val usageByPackage24h = mutableMapOf<String, Long>()

		var beforeBedMs = 0L
		var weekendUsageMs = 0L

		// Phone checks: count actual "sessions" — a new session starts when
		// there has been no foreground activity for at least 60 seconds.
		var phoneChecks = 0
		var lastAnyBackgroundTime = 0L
		val sessionGapThreshold = 60_000L  // 60 seconds gap = new session

		val event = UsageEvents.Event()
		while (events.hasNextEvent()) {
			events.getNextEvent(event)
			val pkg = event.packageName ?: continue
			val time = event.timeStamp

			// Use only ACTIVITY_RESUMED/PAUSED (API 29+) to avoid double-counting
			val isForeground = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
				event.eventType == UsageEvents.Event.ACTIVITY_RESUMED
			} else {
				event.eventType == UsageEvents.Event.MOVE_TO_FOREGROUND
			}
			val isBackground = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
				event.eventType == UsageEvents.Event.ACTIVITY_PAUSED
			} else {
				event.eventType == UsageEvents.Event.MOVE_TO_BACKGROUND
			}

			if (isForeground) {
				lastForeground[pkg] = time

				// Count phone checks: only within last 24h and only when
				// there was a significant gap since the last activity
				if (time >= start24h) {
					if (lastAnyBackgroundTime == 0L ||
						(time - lastAnyBackgroundTime) >= sessionGapThreshold) {
						phoneChecks += 1
					}
				}
			}

			if (isBackground) {
				val startTime = lastForeground.remove(pkg) ?: continue
				val duration = time - startTime
				if (duration <= 0) continue

				lastAnyBackgroundTime = time

				// ── Daily usage: only count the portion within the last 24h ──
				if (time >= start24h) {
					val clampedStart = maxOf(startTime, start24h)
					val sessionInWindow = time - clampedStart
					if (sessionInWindow > 0) {
						dailyUsageMs += sessionInWindow
						appsUsedToday.add(pkg)
						usageByPackage24h[pkg] =
							(usageByPackage24h[pkg] ?: 0L) + sessionInWindow
					}
				}

				// Bedtime overlap
				val overlapBed = overlapMs(startTime, time, bedStart, bedEnd)
				if (overlapBed > 0) {
					beforeBedMs += overlapBed
				}

				// Weekend usage (from 7-day window)
				if (isWeekend(startTime)) {
					weekendUsageMs += duration
				}
			}
		}

		// Handle still-open apps (currently in foreground)
		for ((pkg, startTime) in lastForeground) {
			val endTime = now
			val duration = endTime - startTime
			if (duration <= 0) continue

			// Daily usage for still-open apps
			if (endTime >= start24h) {
				val clampedStart = maxOf(startTime, start24h)
				val sessionInWindow = endTime - clampedStart
				if (sessionInWindow > 0) {
					dailyUsageMs += sessionInWindow
					appsUsedToday.add(pkg)
					usageByPackage24h[pkg] =
						(usageByPackage24h[pkg] ?: 0L) + sessionInWindow
				}
			}

			val overlapBed = overlapMs(startTime, endTime, bedStart, bedEnd)
			if (overlapBed > 0) {
				beforeBedMs += overlapBed
			}

			if (isWeekend(startTime)) {
				weekendUsageMs += duration
			}
		}

		// Calculate per-category usage from the accurate events data
		val socialMs = usageByPackage24h
			.filterKeys { isSocialPackage(it) }
			.values
			.sum()
		val gamingMs = usageByPackage24h
			.filterKeys { isGamingPackage(it) }
			.values
			.sum()

		// Average weekend usage per day (from 7-day data, typically 2 weekend days)
		val weekendDaysInWindow = countWeekendDays(start7d, now)
		val avgWeekendHours = if (weekendDaysInWindow > 0) {
			msToHours(weekendUsageMs) / weekendDaysInWindow
		} else {
			msToHours(weekendUsageMs)
		}

		return mapOf(
			"is_available" to true,
			"daily_usage_hours" to roundTo2(msToHours(dailyUsageMs)),
			"screen_time_before_bed" to roundTo2(msToHours(beforeBedMs)),
			"phone_check_per_day" to phoneChecks,
			"apps_used_daily" to appsUsedToday.size,
			"time_on_social_media" to roundTo2(msToHours(socialMs)),
			"time_in_gaming" to roundTo2(msToHours(gamingMs)),
			"weekend_usage_hours" to roundTo2(avgWeekendHours),
			"collected_at" to isoNowString(),
		)
	}

	private fun msToHours(value: Long): Double {
		return value.toDouble() / 1000.0 / 60.0 / 60.0
	}

	private fun roundTo2(value: Double): Double {
		return Math.round(value * 100.0) / 100.0
	}

	private fun overlapMs(
		start: Long,
		end: Long,
		windowStart: Long,
		windowEnd: Long,
	): Long {
		val overlapStart = maxOf(start, windowStart)
		val overlapEnd = minOf(end, windowEnd)
		return if (overlapEnd > overlapStart) overlapEnd - overlapStart else 0L
	}

	private fun buildBedtimeWindow(now: Long): Pair<Long, Long> {
		val calendar = Calendar.getInstance()
		calendar.timeInMillis = now

		if (calendar.get(Calendar.HOUR_OF_DAY) < 21) {
			calendar.add(Calendar.DAY_OF_YEAR, -1)
		}

		calendar.set(Calendar.HOUR_OF_DAY, 21)
		calendar.set(Calendar.MINUTE, 0)
		calendar.set(Calendar.SECOND, 0)
		calendar.set(Calendar.MILLISECOND, 0)
		val start = calendar.timeInMillis

		calendar.add(Calendar.DAY_OF_YEAR, 1)
		calendar.set(Calendar.HOUR_OF_DAY, 0)
		calendar.set(Calendar.MINUTE, 0)
		calendar.set(Calendar.SECOND, 0)
		calendar.set(Calendar.MILLISECOND, 0)
		val end = calendar.timeInMillis

		return Pair(start, end)
	}

	private fun isWeekend(timestamp: Long): Boolean {
		val calendar = Calendar.getInstance()
		calendar.timeInMillis = timestamp
		return calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY ||
			calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY
	}

	private fun countWeekendDays(startMs: Long, endMs: Long): Int {
		var count = 0
		val cal = Calendar.getInstance()
		cal.timeInMillis = startMs
		// Reset to start of day
		cal.set(Calendar.HOUR_OF_DAY, 0)
		cal.set(Calendar.MINUTE, 0)
		cal.set(Calendar.SECOND, 0)
		cal.set(Calendar.MILLISECOND, 0)

		while (cal.timeInMillis <= endMs) {
			val dow = cal.get(Calendar.DAY_OF_WEEK)
			if (dow == Calendar.SATURDAY || dow == Calendar.SUNDAY) {
				count++
			}
			cal.add(Calendar.DAY_OF_YEAR, 1)
		}
		return count
	}

	private fun isSocialPackage(packageName: String): Boolean {
		val normalized = packageName.lowercase(Locale.getDefault())
		if (normalized in socialPackages) return true
		return normalized.startsWith("com.facebook") ||
			normalized.startsWith("com.instagram") ||
			normalized.startsWith("com.snapchat") ||
			normalized.startsWith("com.zhiliaoapp.musically")
	}

	private fun isGamingPackage(packageName: String): Boolean {
		val normalized = packageName.lowercase(Locale.getDefault())
		if (normalized in gamingPackages) return true
		return normalized.contains(".game") ||
			normalized.contains(".games") ||
			normalized.contains("gaming")
	}

	private fun isoNowString(): String {
		val formatter = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.US)
		formatter.timeZone = java.util.TimeZone.getTimeZone("UTC")
		return formatter.format(Date())
	}

	companion object {
		private val socialPackages = setOf(
			"com.facebook.katana",
			"com.facebook.orca",
			"com.facebook.lite",
			"com.instagram.android",
			"com.twitter.android",
			"com.snapchat.android",
			"com.zhiliaoapp.musically",
			"com.reddit.frontpage",
			"com.pinterest",
			"com.linkedin.android",
			"com.discord",
			"com.whatsapp",
			"com.whatsapp.w4b",
			"org.telegram.messenger",
			"org.thunderdog.challegram",
			"com.viber.voip",
		)

		private val gamingPackages = setOf(
			"com.supercell.clashofclans",
			"com.supercell.clashroyale",
			"com.supercell.brawlstars",
			"com.king.candycrushsaga",
			"com.mojang.minecraftpe",
			"com.epicgames.fortnite",
			"com.activision.callofduty.shooter",
			"com.tencent.ig",
			"com.dts.freefireth",
		)
	}
}
