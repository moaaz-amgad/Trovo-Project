// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiagnosisResponse _$DiagnosisResponseFromJson(Map<String, dynamic> json) =>
    _DiagnosisResponse(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      data: json['data'] as Map<String, dynamic>?,
      errors: json['errors'],
    );

Map<String, dynamic> _$DiagnosisResponseToJson(_DiagnosisResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'errors': instance.errors,
    };
