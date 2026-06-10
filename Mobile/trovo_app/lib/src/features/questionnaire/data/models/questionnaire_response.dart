import 'package:freezed_annotation/freezed_annotation.dart';

part 'questionnaire_response.freezed.dart';
part 'questionnaire_response.g.dart';

@freezed
abstract class QuestionnaireResponse with _$QuestionnaireResponse {
  const QuestionnaireResponse._();

  const factory QuestionnaireResponse({
    @Default('') String phonePurpose,
    @Default('') String name,
    @Default(21) int age,
    @Default('') String gender,
    @Default(8) int sleepHours,
    @Default(50) int academicPerformance,
    @Default(5) int socialInteractionScore,
    @Default(2) int physicalExerciseHours,
    @Default(5) int sadnessFrequency,
    @Default(5) int selfEsteemScore,
    @Default(4) int dailyPhoneUsageHours,
    @Default('Focus') String primaryGoal,
  }) = _QuestionnaireResponse;

  factory QuestionnaireResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireResponseFromJson(json);

  Map<String, String> toApiQuestionnairePayload() {
    return {
      'gender': _normalizeGender(gender),
      'sleep_hours': sleepHours.toString(),
      'academic_performance': academicPerformance.toString(),
      'social_interactions': socialInteractionScore.toString(),
      'exercise_hours': physicalExerciseHours.toString(),
      'anxiety_level': sadnessFrequency.toString(),
      'depression_level': sadnessFrequency.toString(),
      'self_esteem': selfEsteemScore.toString(),
      'time_on_education': '2',
    };
  }

  Map<String, String> toApiPhoneUsagePayload() {
    final double daily = dailyPhoneUsageHours.toDouble();
    final double screenBeforeBed = _clampDouble(daily * 0.25, 0.5, 3.0);
    final int phoneChecks = (daily * 8).round();
    const int appsUsed = 10;
    final double timeOnSocial = _clampDouble(daily * 0.5, 0.5, daily);
    final double timeOnGaming = _clampDouble(daily * 0.2, 0.0, daily);
    final double weekend = daily + 2;

    return {
      'daily_usage_hours': daily.toStringAsFixed(1),
      'screen_time_before_bed': screenBeforeBed.toStringAsFixed(1),
      'phone_checks_per_day': phoneChecks.toString(),
      'apps_used_daily': appsUsed.toString(),
      'time_on_social_media': timeOnSocial.toStringAsFixed(1),
      'time_on_gaming': timeOnGaming.toStringAsFixed(1),
      'phone_usage_purpose': _normalizePhonePurpose(phonePurpose),
      'weekend_usage_hours': weekend.toStringAsFixed(1),
    };
  }

  String _normalizeGender(String value) {
    final normalized = value.trim().toLowerCase();
    if (normalized == 'male' || normalized == 'female' || normalized == 'other') {
      return normalized;
    }
    return 'other';
  }

  String _normalizePhonePurpose(String value) {
    switch (value.trim()) {
      case 'Social Media':
        return 'Social Media';
      case 'Gaming':
        return 'Gaming';
      case 'Education':
        return 'Education';
      case 'Other':
        return 'Other';
      default:
        return 'Other';
    }
  }

  double _clampDouble(double value, double min, double max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }
}
