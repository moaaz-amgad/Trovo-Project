import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../datasources/questionnaire_local_data_source.dart';
import '../models/questionnaire_response.dart';

abstract class QuestionnaireRepository {
  Future<void> saveDraft({
    required QuestionnaireResponse response,
    required int step,
  });
  Future<QuestionnaireDraft?> loadDraft();
  Future<void> clearDraft();

  Future<QuestionnaireResponse?> loadSubmittedAnswers();
  Future<void> clearSubmittedAnswers();

  Future<Either<Failure, Unit>> submitAnswers(QuestionnaireResponse response);

  Future<Either<Failure, Map<String, dynamic>>> fetchHistory();
}
