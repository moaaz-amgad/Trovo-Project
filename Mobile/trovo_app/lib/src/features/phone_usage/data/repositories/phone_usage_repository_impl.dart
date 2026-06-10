import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../datasources/phone_usage_platform_data_source.dart';
import '../datasources/phone_usage_remote_data_source.dart';
import '../models/phone_usage_data.dart';
import '../models/phone_usage_metrics.dart';
import 'phone_usage_repository.dart';

class PhoneUsageRepositoryImpl implements PhoneUsageRepository {
  final PhoneUsageRemoteDataSource _remote;
  final PhoneUsagePlatformDataSource _platform;

  PhoneUsageRepositoryImpl({
    required PhoneUsageRemoteDataSource remote,
    required PhoneUsagePlatformDataSource platform,
  }) : _remote = remote,
       _platform = platform;

  @override
  Future<Either<Failure, Map<String, dynamic>>> submitUsage(
    Map<String, String> fields,
  ) async {
    try {
      final response = await _remote.submitUsage(fields);
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> submitUsageData(
    PhoneUsageData data,
  ) async {
    try {
      final response = await _remote.submitUsageData(data);
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchHistory() async {
    try {
      final response = await _remote.fetchHistory();
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> hasUsageAccess() => _platform.hasUsageAccess();

  @override
  Future<void> openUsageAccessSettings() => _platform.openUsageAccessSettings();

  @override
  Future<PhoneUsagePlatformResult> fetchPlatformUsageData() =>
      _platform.fetchUsageData();
}
