import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../datasources/questionnaire_local_data_source.dart';
import '../datasources/questionnaire_remote_data_source.dart';
import '../models/questionnaire_response.dart';
import 'questionnaire_repository.dart';

class QuestionnaireRepositoryImpl implements QuestionnaireRepository {
  final QuestionnaireRemoteDataSource _remote;
  final QuestionnaireLocalDataSource _local;

  QuestionnaireRepositoryImpl({
    required QuestionnaireRemoteDataSource remote,
    required QuestionnaireLocalDataSource local,
  }) : _remote = remote,
       _local = local;

  @override
  Future<void> saveDraft({
    required QuestionnaireResponse response,
    required int step,
  }) => _local.saveDraft(response: response, step: step);

  @override
  Future<QuestionnaireDraft?> loadDraft() => _local.loadDraft();

  @override
  Future<void> clearDraft() => _local.clearDraft();

  @override
  Future<QuestionnaireResponse?> loadSubmittedAnswers() =>
      _local.loadSubmittedAnswers();

  @override
  Future<void> clearSubmittedAnswers() => _local.clearSubmittedAnswers();

  @override
  Future<Either<Failure, Unit>> submitAnswers(
    QuestionnaireResponse response,
  ) async {
    try {
      await _local.saveSubmittedAnswers(response);
      await _remote.submitResponses(response.toApiQuestionnairePayload());

      await _local.clearDraft();
      return const Right(unit);
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
}
