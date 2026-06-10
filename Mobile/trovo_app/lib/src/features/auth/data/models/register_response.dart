import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_response.freezed.dart';
part 'register_response.g.dart';

Object? _readFullName(Map json, String key) =>
    json['full_name'] ?? json['fullName'] ?? json['name'];

@freezed
abstract class RegisterUser with _$RegisterUser {
  const factory RegisterUser({
    int? id,
    @JsonKey(readValue: _readFullName) String? fullName,
    String? email,
    String? gender,
    int? age,
  }) = _RegisterUser;

  factory RegisterUser.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserFromJson(json);
}

Object? _readUser(Map json, String key) => json['user'] ?? json['data'];

@freezed
abstract class RegisterResponse with _$RegisterResponse {
  const factory RegisterResponse({
    @Default('') String status,
    @Default('') String message,
    @JsonKey(readValue: _readUser) RegisterUser? data,
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'token_type') String? tokenType,
    @JsonKey(name: 'email_verified') bool? emailVerified,
    Object? errors,
  }) = _RegisterResponse;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}
