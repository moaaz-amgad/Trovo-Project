import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_usage_data.freezed.dart';
part 'phone_usage_data.g.dart';

@freezed
abstract class PhoneUsageData with _$PhoneUsageData {
  const PhoneUsageData._();

  const factory PhoneUsageData({
    @JsonKey(name: 'usage_id') @Default(0) int usageId,
    @JsonKey(name: 'user_id') @Default(0) int userId,
    @JsonKey(name: 'diagnosis_id') @Default(0) int diagnosisId,
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
  }) = _PhoneUsageData;

  factory PhoneUsageData.fromJson(Map<String, dynamic> json) =>
      _$PhoneUsageDataFromJson(json);

  Map<String, String> toFormFields() => {
    'usage_id': usageId.toString(),
    'user_id': userId.toString(),
    'diagnosis_id': diagnosisId.toString(),
    'daily_usage_hours': dailyUsageHours.toString(),
    'screen_time_before_bed': screenTimeBeforeBed.toString(),
    'phone_checks_per_day': phoneCheckPerDay.toString(),
    'apps_used_daily': appsUsedDaily.toString(),
    'time_on_social_media': timeOnSocialMedia.toString(),
    'time_on_gaming': timeInGaming.toString(),
    'weekend_usage_hours': weekendUsageHours.toString(),
    'collected_at': (collectedAt ?? DateTime.now()).toIso8601String(),
  };
}
