import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../datasources/progress_remote_data_source.dart';
import '../models/progress_entry.dart';
import '../models/progress_summary.dart';
import 'progress_repository.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  final ProgressRemoteDataSource _remote;

  ProgressRepositoryImpl({required ProgressRemoteDataSource remote})
    : _remote = remote;

  @override
  Future<Either<Failure, ProgressSummary>> fetchSummary() async {
    try {
      return Right(await _remote.fetchSummary());
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProgressEntry>>> fetchHistory() async {
    try {
      return Right(await _remote.fetchHistory());
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
