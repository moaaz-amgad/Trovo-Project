import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

Object? _readFullName(Map json, String key) =>
    json['full_name'] ?? json['fullName'] ?? json['name'];

Object? _readAvatar(Map json, String key) =>
    json['avatar'] ?? json['avatar_url'] ?? json['image'];

Object? _readVerifiedAt(Map json, String key) =>
    json['email_verified_at'] ?? json['emailVerifiedAt'];

/// Authenticated user as returned by `GET /api/user`.
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    int? id,
    @JsonKey(readValue: _readFullName) String? fullName,
    String? email,
    String? gender,
    int? age,
    @JsonKey(readValue: _readAvatar) String? avatar,
    @JsonKey(readValue: _readVerifiedAt) String? emailVerifiedAt,
  }) = _UserProfile;

  const UserProfile._();

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  /// Extracts the user object whether it sits at the root or under `data`.
  factory UserProfile.fromEnvelope(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map<String, dynamic>) {
      final nestedUser = data['user'];
      if (nestedUser is Map<String, dynamic>) {
        return UserProfile.fromJson(nestedUser);
      }
      return UserProfile.fromJson(data);
    }
    final user = json['user'];
    if (user is Map<String, dynamic>) return UserProfile.fromJson(user);
    return UserProfile.fromJson(json);
  }

  bool get isEmailVerified => emailVerifiedAt != null;
}
