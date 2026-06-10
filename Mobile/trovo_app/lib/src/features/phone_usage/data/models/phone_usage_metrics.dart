import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_usage_metrics.freezed.dart';
part 'phone_usage_metrics.g.dart';

@freezed
abstract class PhoneUsageMetrics with _$PhoneUsageMetrics {
  const factory PhoneUsageMetrics({
    @JsonKey(name: 'daily_usage_hours') @Default(0.0) double dailyUsageHours,
    @JsonKey(name: 'screen_time_before_bed')
    @Default(0.0)
    double screenTimeBeforeBed,
    @JsonKey(name: 'phone_check_per_day') @Default(0) int phoneCheckPerDay,
    @JsonKey(name: 'apps_used_daily') @Default(0) int appsUsedDaily,
    @JsonKey(name: 'time_on_social_media')
    @Default(0.0)
    double timeOnSocialMedia,
    @JsonKey(name: 'time_in_gaming') @Default(0.0) double timeInGaming,
    @JsonKey(name: 'weekend_usage_hours')
    @Default(0.0)
    double weekendUsageHours,
    @JsonKey(name: 'collected_at') DateTime? collectedAt,
  }) = _PhoneUsageMetrics;

  factory PhoneUsageMetrics.fromJson(Map<String, dynamic> json) =>
      _$PhoneUsageMetricsFromJson(json);
}

class PhoneUsagePlatformResult {
  const PhoneUsagePlatformResult({
    required this.isAvailable,
    this.message,
    this.metrics,
  });

  const PhoneUsagePlatformResult.unavailable(this.message)
    : isAvailable = false,
      metrics = null;

  final bool isAvailable;
  final String? message;
  final PhoneUsageMetrics? metrics;

  factory PhoneUsagePlatformResult.fromMap(Map<String, dynamic> map) {
    final isAvailable = map['is_available'] as bool? ?? true;
    final message = map['message'] as String?;
    final metrics = isAvailable ? PhoneUsageMetrics.fromJson(map) : null;
    return PhoneUsagePlatformResult(
      isAvailable: isAvailable,
      message: message,
      metrics: metrics,
    );
  }
}
