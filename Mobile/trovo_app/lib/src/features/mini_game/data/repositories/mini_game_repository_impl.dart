import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../datasources/mini_game_remote_data_source.dart';
import '../models/mini_game_dashboard.dart';
import '../models/mini_game_record.dart';
import '../models/mini_game_session.dart';
import '../models/mini_game_stats.dart';
import 'mini_game_repository.dart';

class MiniGameRepositoryImpl implements MiniGameRepository {
  final MiniGameRemoteDataSource _remote;

  MiniGameRepositoryImpl({required MiniGameRemoteDataSource remote})
    : _remote = remote;

  @override
  Future<Either<Failure, MiniGameRecord>> submitSession(
    MiniGameSession session,
  ) async {
    try {
      return Right(await _remote.submitSession(session));
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MiniGameRecord>>> fetchHistory() async {
    try {
      return Right(await _remote.fetchHistory());
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MiniGameStats>> fetchStats() async {
    try {
      return Right(await _remote.fetchStats());
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MiniGameDashboard>> fetchDashboard() async {
    try {
      return Right(await _remote.fetchDashboard());
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
