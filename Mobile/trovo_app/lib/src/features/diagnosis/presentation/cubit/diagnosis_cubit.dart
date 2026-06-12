import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


import '../../data/models/diagnosis_response.dart';
import '../../data/repositories/diagnosis_repository.dart';

part 'diagnosis_cubit.freezed.dart';

@freezed
class DiagnosisState with _$DiagnosisState {
  const factory DiagnosisState.initial() = _DiagnosisInitial;
  const factory DiagnosisState.loading() = _DiagnosisLoading;
  const factory DiagnosisState.generated(DiagnosisResponse data) =
      _DiagnosisGenerated;
  const factory DiagnosisState.history(DiagnosisResponse data) =
      _DiagnosisHistory;
  const factory DiagnosisState.error(String message) = _DiagnosisError;
}

class DiagnosisCubit extends Cubit<DiagnosisState> {
  final DiagnosisRepository _repository;

  DiagnosisCubit({required DiagnosisRepository repository})
    : _repository = repository,
      super(const DiagnosisState.initial());

  Future<void> generateDiagnosis() async {
    emit(const DiagnosisState.loading());
    
    final result = await _repository.generateDiagnosis();
    result.fold(
      (failure) => emit(DiagnosisState.error(failure.message)),
      (response) => emit(DiagnosisState.generated(response)),
    );
  }

  Future<void> fetchHistory() async {
    emit(const DiagnosisState.loading());
    
    final result = await _repository.fetchHistory();
    result.fold(
      (failure) => emit(DiagnosisState.error(failure.message)),
      (response) => emit(DiagnosisState.history(response)),
    );
  }
}
