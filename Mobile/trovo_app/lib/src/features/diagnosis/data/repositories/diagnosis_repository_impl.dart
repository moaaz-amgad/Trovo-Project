import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../datasources/diagnosis_remote_data_source.dart';
import '../models/diagnosis_response.dart';
import 'diagnosis_repository.dart';

class DiagnosisRepositoryImpl implements DiagnosisRepository {
  final DiagnosisRemoteDataSource _remote;

  DiagnosisRepositoryImpl({required DiagnosisRemoteDataSource remote})
    : _remote = remote;

  @override
  Future<Either<Failure, DiagnosisResponse>> generateDiagnosis() async {
    try {
      final response = await _remote.generateDiagnosis();
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DiagnosisResponse>> fetchHistory() async {
    try {
      final response = await _remote.fetchHistory();
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
