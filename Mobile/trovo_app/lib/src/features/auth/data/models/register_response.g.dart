// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterUser _$RegisterUserFromJson(Map<String, dynamic> json) =>
    _RegisterUser(
      id: (json['id'] as num?)?.toInt(),
      fullName: _readFullName(json, 'fullName') as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      age: (json['age'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RegisterUserToJson(_RegisterUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'gender': instance.gender,
      'age': instance.age,
    };

_RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    _RegisterResponse(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      data: _readUser(json, 'data') == null
          ? null
          : RegisterUser.fromJson(
              _readUser(json, 'data') as Map<String, dynamic>,
            ),
      accessToken: json['access_token'] as String?,
      tokenType: json['token_type'] as String?,
      emailVerified: json['email_verified'] as bool?,
      errors: json['errors'],
    );

Map<String, dynamic> _$RegisterResponseToJson(_RegisterResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'email_verified': instance.emailVerified,
      'errors': instance.errors,
    };
