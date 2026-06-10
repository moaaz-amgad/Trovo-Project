import 'package:dio/dio.dart';

import '../../../../core/network/endpoints.dart';
import '../models/auth_action_response.dart';
import '../models/login_response.dart';
import '../models/register_response.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login({
    required String email,
    required String password,
  });

  Future<LoginResponse> googleLogin({required String idToken});

  Future<RegisterResponse> register({
    required String name,
    required String email,
    required String password,
  });

  Future<AuthActionResponse> verifyEmail({
    required String email,
    required String code,
  });

  Future<AuthActionResponse> resendOtp({
    required String email,
    required String type,
  });

  Future<AuthActionResponse> forgotPassword({required String email});

  Future<AuthActionResponse> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  });

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      Endpoints.login,
      data: FormData.fromMap({'email': email, 'password': password}),
    );
    return LoginResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<LoginResponse> googleLogin({required String idToken}) async {
    final response = await _dio.post(
      Endpoints.googleAuth,
      data: FormData.fromMap({'id_token': idToken}),
    );
    return LoginResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<RegisterResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      Endpoints.register,
      data: FormData.fromMap({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
      }),
    );
    return RegisterResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AuthActionResponse> verifyEmail({
    required String email,
    required String code,
  }) async {
    final response = await _dio.post(
      Endpoints.verifyEmail,
      data: FormData.fromMap({'email': email, 'code': code}),
    );
    return AuthActionResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AuthActionResponse> resendOtp({
    required String email,
    required String type,
  }) async {
    final response = await _dio.post(
      Endpoints.resendOtp,
      data: FormData.fromMap({'email': email, 'type': type}),
    );
    return AuthActionResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AuthActionResponse> forgotPassword({required String email}) async {
    final response = await _dio.post(
      Endpoints.forgotPassword,
      data: FormData.fromMap({'email': email}),
    );
    return AuthActionResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AuthActionResponse> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    final response = await _dio.post(
      Endpoints.resetPassword,
      data: FormData.fromMap({
        'email': email,
        'code': code,
        'password': newPassword,
      }),
    );
    return AuthActionResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> logout() async {
    await _dio.post(Endpoints.logout);
  }
}
