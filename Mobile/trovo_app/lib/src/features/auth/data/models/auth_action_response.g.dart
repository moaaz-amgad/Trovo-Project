// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_action_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthActionResponse _$AuthActionResponseFromJson(Map<String, dynamic> json) =>
    _AuthActionResponse(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      accessToken: json['access_token'] as String?,
      data: json['data'],
      errors: json['errors'],
    );

Map<String, dynamic> _$AuthActionResponseToJson(_AuthActionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'access_token': instance.accessToken,
      'data': instance.data,
      'errors': instance.errors,
    };
