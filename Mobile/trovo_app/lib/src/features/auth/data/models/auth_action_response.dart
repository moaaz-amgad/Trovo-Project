import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_action_response.freezed.dart';
part 'auth_action_response.g.dart';

@freezed
abstract class AuthActionResponse with _$AuthActionResponse {
  const factory AuthActionResponse({
    @Default('') String status,
    @Default('') String message,
    @JsonKey(name: 'access_token') String? accessToken,
    Object? data,
    Object? errors,
  }) = _AuthActionResponse;

  factory AuthActionResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthActionResponseFromJson(json);
}
