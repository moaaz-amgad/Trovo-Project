import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_action_response.dart';
import '../models/login_response.dart';
import '../models/register_response.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final SecureStorageService _secureStorage;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required SecureStorageService secureStorage,
  }) : _remote = remote,
       _secureStorage = secureStorage;

  Future<void> _persistSession(LoginResponse response) async {
    final accessToken = response.resolvedAccessToken;
    if (accessToken.isNotEmpty) {
      await _secureStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: response.resolvedRefreshToken,
      );
    }
    final user = response.resolvedUser;
    if (user != null) {
      await _secureStorage.saveUserData(jsonEncode(user.toJson()));
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remote.login(email: email, password: password);
      await _persistSession(response);
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> googleLogin({
    required String idToken,
  }) async {
    try {
      final response = await _remote.googleLogin(idToken: idToken);
      await _persistSession(response);
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RegisterResponse>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remote.register(
        name: name,
        email: email,
        password: password,
      );
      final token = response.accessToken;
      if (token != null && token.isNotEmpty) {
        await _secureStorage.saveTokens(
          accessToken: token,
          refreshToken: token,
        );
      }
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthActionResponse>> verifyEmail({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _remote.verifyEmail(email: email, code: code);
      final token = response.accessToken;
      if (token != null && token.isNotEmpty) {
        await _secureStorage.saveTokens(
          accessToken: token,
          refreshToken: token,
        );
      }
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthActionResponse>> resendOtp({
    required String email,
    String type = 'email_verification',
  }) async {
    return _action(() => _remote.resendOtp(email: email, type: type));
  }

  @override
  Future<Either<Failure, AuthActionResponse>> forgotPassword({
    required String email,
  }) async {
    return _action(
      () => _remote.forgotPassword(email: email),
      failureMessage: 'Failed to send OTP',
    );
  }

  @override
  Future<Either<Failure, AuthActionResponse>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    return _action(
      () => _remote.resetPassword(
        email: email,
        code: code,
        newPassword: newPassword,
      ),
      failureMessage: 'Failed to reset password',
    );
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await _remote.logout();
    } on DioException catch (_) {
      // Silent — still clear local tokens below.
    } catch (_) {
      // Silent — still clear local tokens below.
    }
    await _secureStorage.removeTokens();
    await _secureStorage.removeUserData();
    return const Right(unit);
  }

  /// Shared wrapper for simple message-only auth actions.
  Future<Either<Failure, AuthActionResponse>> _action(
    Future<AuthActionResponse> Function() call, {
    String? failureMessage,
  }) async {
    try {
      final response = await call();
      if (response.status != 'success' && failureMessage != null) {
        return Left(
          ServerFailure(
            message: response.message.isEmpty
                ? failureMessage
                : response.message,
          ),
        );
      }
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
