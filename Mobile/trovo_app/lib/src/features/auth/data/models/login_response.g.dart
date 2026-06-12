// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginUser _$LoginUserFromJson(Map<String, dynamic> json) => _LoginUser(
  id: (json['id'] as num?)?.toInt(),
  fullName: _readFullName(json, 'fullName') as String?,
  email: json['email'] as String?,
  gender: json['gender'] as String?,
  age: (json['age'] as num?)?.toInt(),
  avatar: _readAvatar(json, 'avatar') as String?,
);

Map<String, dynamic> _$LoginUserToJson(_LoginUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'gender': instance.gender,
      'age': instance.age,
      'avatar': instance.avatar,
    };

_LoginResponseData _$LoginResponseDataFromJson(Map<String, dynamic> json) =>
    _LoginResponseData(
      accessToken: _readAccessToken(json, 'accessToken') as String?,
      refreshToken: _readRefreshToken(json, 'refreshToken') as String?,
      user: _readUser(json, 'user') == null
          ? null
          : LoginUser.fromJson(_readUser(json, 'user') as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseDataToJson(_LoginResponseData instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };

_LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    _LoginResponse(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      data: json['data'] == null
          ? null
          : LoginResponseData.fromJson(json['data'] as Map<String, dynamic>),
      token: _readToken(json, 'token') as String?,
      hasDiagnosis: _readHasDiagnosis(json, 'hasDiagnosis') as bool? ?? false,
      errors: json['errors'],
    );

Map<String, dynamic> _$LoginResponseToJson(_LoginResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'token': instance.token,
      'hasDiagnosis': instance.hasDiagnosis,
      'errors': instance.errors,
    };
