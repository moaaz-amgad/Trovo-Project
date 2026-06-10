import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/progress_entry.dart';
import '../../data/models/progress_summary.dart';
import '../../data/repositories/progress_repository.dart';

part 'progress_cubit.freezed.dart';

@freezed
class ProgressState with _$ProgressState {
  const factory ProgressState.initial() = _ProgressInitial;
  const factory ProgressState.loading() = _ProgressLoading;
  const factory ProgressState.loaded({
    ProgressSummary? summary,
    @Default(<ProgressEntry>[]) List<ProgressEntry> history,
  }) = _ProgressLoaded;
  const factory ProgressState.error(String message) = _ProgressError;
}

class ProgressCubit extends Cubit<ProgressState> {
  final ProgressRepository _repository;

  ProgressCubit({required ProgressRepository repository})
    : _repository = repository,
      super(const ProgressState.initial());

  /// Loads the summary and history together for the progress dashboard.
  Future<void> load() async {
    emit(const ProgressState.loading());
    final summaryResult = await _repository.fetchSummary();
    final historyResult = await _repository.fetchHistory();

    final failure = summaryResult.fold((f) => f, (_) => null) ??
        historyResult.fold((f) => f, (_) => null);

    if (failure != null) {
      emit(ProgressState.error(failure.message));
      return;
    }

    emit(
      ProgressState.loaded(
        summary: summaryResult.getOrElse(() => const ProgressSummary()),
        history: historyResult.getOrElse(() => const []),
      ),
    );
  }
}
