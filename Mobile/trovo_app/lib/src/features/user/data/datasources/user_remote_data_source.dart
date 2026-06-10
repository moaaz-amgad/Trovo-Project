import 'package:dio/dio.dart';

import '../../../../core/network/api_message.dart';
import '../../../../core/network/endpoints.dart';
import '../models/user_profile.dart';

abstract class UserRemoteDataSource {
  Future<UserProfile> getProfile();

  Future<UserProfile> updateProfile({String? name, String? avatar});

  Future<ApiMessage> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<ApiMessage> deleteAccount();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio _dio;

  UserRemoteDataSourceImpl(this._dio);

  @override
  Future<UserProfile> getProfile() async {
    final response = await _dio.get(Endpoints.user);
    return UserProfile.fromEnvelope(response.data as Map<String, dynamic>);
  }

  @override
  Future<UserProfile> updateProfile({String? name, String? avatar}) async {
    final fields = <String, dynamic>{};
    if (name != null) fields['name'] = name;
    if (avatar != null) fields['avatar'] = avatar;

    final response = await _dio.put(
      Endpoints.updateProfile,
      data: FormData.fromMap(fields),
    );
    return UserProfile.fromEnvelope(response.data as Map<String, dynamic>);
  }

  @override
  Future<ApiMessage> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await _dio.post(
      Endpoints.changePassword,
      data: FormData.fromMap({
        'current_password': currentPassword,
        'password': newPassword,
      }),
    );
    return ApiMessage.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<ApiMessage> deleteAccount() async {
    final response = await _dio.delete(Endpoints.deleteAccount);
    return ApiMessage.fromJson(response.data as Map<String, dynamic>);
  }
}
