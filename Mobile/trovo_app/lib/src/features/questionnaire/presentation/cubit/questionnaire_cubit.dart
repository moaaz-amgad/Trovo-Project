import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/datasources/questionnaire_local_data_source.dart';
import '../../data/models/questionnaire_response.dart';
import '../../data/repositories/questionnaire_repository.dart';

part 'questionnaire_cubit.freezed.dart';

@freezed
class QuestionnaireState with _$QuestionnaireState {
  const factory QuestionnaireState.initial() = _QuestionnaireInitial;
  const factory QuestionnaireState.loadingDraft() = _QuestionnaireLoadingDraft;
  const factory QuestionnaireState.draftLoaded(QuestionnaireDraft? draft) =
      _QuestionnaireDraftLoaded;
  const factory QuestionnaireState.submitting() = _QuestionnaireSubmitting;
  const factory QuestionnaireState.submitted() = _QuestionnaireSubmitted;
  const factory QuestionnaireState.error(String message) = _QuestionnaireError;
}

class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  final QuestionnaireRepository _repository;

  QuestionnaireCubit({required QuestionnaireRepository repository})
    : _repository = repository,
      super(const QuestionnaireState.initial());

  Future<void> loadDraft() async {
    emit(const QuestionnaireState.loadingDraft());
    final draft = await _repository.loadDraft();
    emit(QuestionnaireState.draftLoaded(draft));
  }

  Future<void> saveDraft({
    required QuestionnaireResponse response,
    required int step,
  }) => _repository.saveDraft(response: response, step: step);

  Future<void> clearDraft() => _repository.clearDraft();

  Future<void> submit(QuestionnaireResponse response) async {
    emit(const QuestionnaireState.submitting());
    final result = await _repository.submitAnswers(response);
    result.fold(
      (failure) => emit(QuestionnaireState.error(failure.message)),
      (_) => emit(const QuestionnaireState.submitted()),
    );
  }
}
