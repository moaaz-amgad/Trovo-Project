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
		val start7d = now - DateUtils.DAY_IN_MILLIS * 7
		val start24h = now - DateUtils.DAY_IN_MILLIS
		val bedWindow = buildBedtimeWindow(now)
		val bedStart = bedWindow.first
		val bedEnd = bedWindow.second

		val events = usageStatsManager.queryEvents(start7d, now)
		val lastForeground = mutableMapOf<String, Long>()
		val usageByPackage = mutableMapOf<String, Long>()
		val appsUsedToday = mutableSetOf<String>()

		var dailyUsageMs = 0L
		var weekendUsageMs = 0L
		var beforeBedMs = 0L
		var phoneChecks = 0

		val event = UsageEvents.Event()
		while (events.hasNextEvent()) {
			events.getNextEvent(event)
			val pkg = event.packageName ?: continue
			val time = event.timeStamp

			val isForeground =
				event.eventType == UsageEvents.Event.MOVE_TO_FOREGROUND ||
					event.eventType == UsageEvents.Event.ACTIVITY_RESUMED
			val isBackground =
				event.eventType == UsageEvents.Event.MOVE_TO_BACKGROUND ||
					event.eventType == UsageEvents.Event.ACTIVITY_PAUSED

			if (isForeground) {
				lastForeground[pkg] = time
				if (time >= start24h) {
					phoneChecks += 1
				}
			}

			if (isBackground) {
				val startTime = lastForeground.remove(pkg) ?: continue
				val duration = time - startTime
				if (duration <= 0) continue

				val overlap24h = overlapMs(startTime, time, start24h, now)
				if (overlap24h > 0) {
					dailyUsageMs += overlap24h
					usageByPackage[pkg] = (usageByPackage[pkg] ?: 0L) + overlap24h
					appsUsedToday.add(pkg)
				}

				val overlapBed = overlapMs(startTime, time, bedStart, bedEnd)
				if (overlapBed > 0) {
					beforeBedMs += overlapBed
				}

				if (isWeekend(startTime)) {
					weekendUsageMs += duration
				}
			}
		}

		for ((pkg, startTime) in lastForeground) {
			val endTime = now
			val duration = endTime - startTime
			if (duration <= 0) continue

			val overlap24h = overlapMs(startTime, endTime, start24h, now)
			if (overlap24h > 0) {
				dailyUsageMs += overlap24h
				usageByPackage[pkg] = (usageByPackage[pkg] ?: 0L) + overlap24h
				appsUsedToday.add(pkg)
			}

			val overlapBed = overlapMs(startTime, endTime, bedStart, bedEnd)
			if (overlapBed > 0) {
				beforeBedMs += overlapBed
			}

			if (isWeekend(startTime)) {
				weekendUsageMs += duration
			}
		}

		val socialMs = usageByPackage
			.filterKeys { isSocialPackage(it) }
			.values
			.sum()
		val gamingMs = usageByPackage
			.filterKeys { isGamingPackage(it) }
			.values
			.sum()

		return mapOf(
			"is_available" to true,
			"daily_usage_hours" to msToHours(dailyUsageMs),
			"screen_time_before_bed" to msToHours(beforeBedMs),
			"phone_check_per_day" to phoneChecks,
			"apps_used_daily" to appsUsedToday.size,
			"time_on_social_media" to msToHours(socialMs),
			"time_in_gaming" to msToHours(gamingMs),
			"weekend_usage_hours" to msToHours(weekendUsageMs),
			"collected_at" to isoNowString(),
		)
	}

	private fun msToHours(value: Long): Double {
		return value.toDouble() / 1000.0 / 60.0 / 60.0
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
			"com.instagram.android",
			"com.twitter.android",
			"com.snapchat.android",
			"com.zhiliaoapp.musically",
			"com.reddit.frontpage",
			"com.pinterest",
			"com.linkedin.android",
			"com.discord",
			"com.whatsapp",
			"org.telegram.messenger",
		)

		private val gamingPackages = setOf(
			"com.supercell.clashofclans",
			"com.supercell.clashroyale",
			"com.supercell.brawlstars",
			"com.king.candycrushsaga",
			"com.mojang.minecraftpe",
			"com.epicgames.fortnite",
		)
	}
}
