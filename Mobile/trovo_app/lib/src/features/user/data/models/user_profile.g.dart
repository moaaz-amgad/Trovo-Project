// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: (json['id'] as num?)?.toInt(),
  fullName: _readFullName(json, 'fullName') as String?,
  email: json['email'] as String?,
  gender: json['gender'] as String?,
  age: (json['age'] as num?)?.toInt(),
  avatar: _readAvatar(json, 'avatar') as String?,
  emailVerifiedAt: _readVerifiedAt(json, 'emailVerifiedAt') as String?,
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'gender': instance.gender,
      'age': instance.age,
      'avatar': instance.avatar,
      'emailVerifiedAt': instance.emailVerifiedAt,
    };
