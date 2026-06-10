// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionnaire_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuestionnaireResponse _$QuestionnaireResponseFromJson(
  Map<String, dynamic> json,
) => _QuestionnaireResponse(
  phonePurpose: json['phonePurpose'] as String? ?? '',
  name: json['name'] as String? ?? '',
  age: (json['age'] as num?)?.toInt() ?? 21,
  gender: json['gender'] as String? ?? '',
  sleepHours: (json['sleepHours'] as num?)?.toInt() ?? 8,
  academicPerformance: (json['academicPerformance'] as num?)?.toInt() ?? 50,
  socialInteractionScore:
      (json['socialInteractionScore'] as num?)?.toInt() ?? 5,
  physicalExerciseHours: (json['physicalExerciseHours'] as num?)?.toInt() ?? 2,
  sadnessFrequency: (json['sadnessFrequency'] as num?)?.toInt() ?? 5,
  selfEsteemScore: (json['selfEsteemScore'] as num?)?.toInt() ?? 5,
  dailyPhoneUsageHours: (json['dailyPhoneUsageHours'] as num?)?.toInt() ?? 4,
  primaryGoal: json['primaryGoal'] as String? ?? 'Focus',
);

Map<String, dynamic> _$QuestionnaireResponseToJson(
  _QuestionnaireResponse instance,
) => <String, dynamic>{
  'phonePurpose': instance.phonePurpose,
  'name': instance.name,
  'age': instance.age,
  'gender': instance.gender,
  'sleepHours': instance.sleepHours,
  'academicPerformance': instance.academicPerformance,
  'socialInteractionScore': instance.socialInteractionScore,
  'physicalExerciseHours': instance.physicalExerciseHours,
  'sadnessFrequency': instance.sadnessFrequency,
  'selfEsteemScore': instance.selfEsteemScore,
  'dailyPhoneUsageHours': instance.dailyPhoneUsageHours,
  'primaryGoal': instance.primaryGoal,
};
