import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

// --- Tolerant readers -------------------------------------------------------
// The backend may expose fields in snake_case or camelCase and may place the
// token at the root or inside `data`. These readers normalise both shapes so a
// single model works regardless of the exact server contract.

Object? _readFullName(Map json, String key) =>
    json['full_name'] ?? json['fullName'] ?? json['name'];

Object? _readAvatar(Map json, String key) =>
    json['avatar'] ?? json['avatar_url'] ?? json['image'];

Object? _readAccessToken(Map json, String key) =>
    json['accessToken'] ?? json['access_token'] ?? json['token'];

Object? _readRefreshToken(Map json, String key) =>
    json['refreshToken'] ?? json['refresh_token'];

Object? _readUser(Map json, String key) {
  final user = json['user'];
  if (user is Map) return user;
  // Some endpoints return the user fields directly inside `data`.
  if (json.containsKey('email') || json.containsKey('full_name')) return json;
  return null;
}

Object? _readToken(Map json, String key) =>
    json['token'] ?? json['access_token'];

@freezed
abstract class LoginUser with _$LoginUser {
  const factory LoginUser({
    int? id,
    @JsonKey(readValue: _readFullName) String? fullName,
    String? email,
    String? gender,
    int? age,
    @JsonKey(readValue: _readAvatar) String? avatar,
  }) = _LoginUser;

  factory LoginUser.fromJson(Map<String, dynamic> json) =>
      _$LoginUserFromJson(json);
}

@freezed
abstract class LoginResponseData with _$LoginResponseData {
  const factory LoginResponseData({
    @JsonKey(readValue: _readAccessToken) String? accessToken,
    @JsonKey(readValue: _readRefreshToken) String? refreshToken,
    @JsonKey(readValue: _readUser) LoginUser? user,
  }) = _LoginResponseData;

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataFromJson(json);
}

@freezed
abstract class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    @Default('') String status,
    @Default('') String message,
    LoginResponseData? data,
    @JsonKey(readValue: _readToken) String? token,
    Object? errors,
  }) = _LoginResponse;

  const LoginResponse._();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  /// Resolves the bearer token regardless of where the API places it.
  String get resolvedAccessToken => token ?? data?.accessToken ?? '';

  /// Falls back to the access token when the API issues a single token.
  String get resolvedRefreshToken =>
      data?.refreshToken ?? resolvedAccessToken;

  LoginUser? get resolvedUser => data?.user;
}
