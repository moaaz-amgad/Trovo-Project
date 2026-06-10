import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_profile.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remote;
  final SecureStorageService _secureStorage;

  UserRepositoryImpl({
    required UserRemoteDataSource remote,
    required SecureStorageService secureStorage,
  }) : _remote = remote,
       _secureStorage = secureStorage;

  @override
  Future<Either<Failure, UserProfile>> getProfile() async {
    try {
      final profile = await _remote.getProfile();
      await _secureStorage.saveUserData(jsonEncode(profile.toJson()));
      return Right(profile);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateProfile({
    String? name,
    String? avatar,
  }) async {
    try {
      final profile = await _remote.updateProfile(name: name, avatar: avatar);
      await _secureStorage.saveUserData(jsonEncode(profile.toJson()));
      return Right(profile);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final result = await _remote.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return Right(
        result.message.isEmpty ? 'Password changed' : result.message,
      );
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAccount() async {
    try {
      final result = await _remote.deleteAccount();
      await _secureStorage.removeTokens();
      await _secureStorage.removeUserData();
      return Right(
        result.message.isEmpty ? 'Account deleted' : result.message,
      );
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
