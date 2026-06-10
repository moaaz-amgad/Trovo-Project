// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_usage_metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhoneUsageMetrics _$PhoneUsageMetricsFromJson(
  Map<String, dynamic> json,
) => _PhoneUsageMetrics(
  dailyUsageHours: (json['daily_usage_hours'] as num?)?.toDouble() ?? 0.0,
  screenTimeBeforeBed:
      (json['screen_time_before_bed'] as num?)?.toDouble() ?? 0.0,
  phoneCheckPerDay: (json['phone_check_per_day'] as num?)?.toInt() ?? 0,
  appsUsedDaily: (json['apps_used_daily'] as num?)?.toInt() ?? 0,
  timeOnSocialMedia: (json['time_on_social_media'] as num?)?.toDouble() ?? 0.0,
  timeInGaming: (json['time_in_gaming'] as num?)?.toDouble() ?? 0.0,
  weekendUsageHours: (json['weekend_usage_hours'] as num?)?.toDouble() ?? 0.0,
  collectedAt: json['collected_at'] == null
      ? null
      : DateTime.parse(json['collected_at'] as String),
);

Map<String, dynamic> _$PhoneUsageMetricsToJson(_PhoneUsageMetrics instance) =>
    <String, dynamic>{
      'daily_usage_hours': instance.dailyUsageHours,
      'screen_time_before_bed': instance.screenTimeBeforeBed,
      'phone_check_per_day': instance.phoneCheckPerDay,
      'apps_used_daily': instance.appsUsedDaily,
      'time_on_social_media': instance.timeOnSocialMedia,
      'time_in_gaming': instance.timeInGaming,
      'weekend_usage_hours': instance.weekendUsageHours,
      'collected_at': instance.collectedAt?.toIso8601String(),
    };
