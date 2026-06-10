import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/mini_game_dashboard.dart';
import '../../data/models/mini_game_record.dart';
import '../../data/models/mini_game_stats.dart';
import '../../data/repositories/mini_game_repository.dart';

part 'mini_game_cubit.freezed.dart';

@freezed
class MiniGameDashboardState with _$MiniGameDashboardState {
  const factory MiniGameDashboardState.initial() = _MiniGameInitial;
  const factory MiniGameDashboardState.loading() = _MiniGameLoading;
  const factory MiniGameDashboardState.loaded({
    MiniGameDashboard? dashboard,
    MiniGameStats? stats,
    @Default(<MiniGameRecord>[]) List<MiniGameRecord> history,
  }) = _MiniGameLoaded;
  const factory MiniGameDashboardState.error(String message) = _MiniGameError;
}

class MiniGameCubit extends Cubit<MiniGameDashboardState> {
  final MiniGameRepository _repository;

  MiniGameCubit({required MiniGameRepository repository})
    : _repository = repository,
      super(const MiniGameDashboardState.initial());

  Future<void> loadDashboard() async {
    emit(const MiniGameDashboardState.loading());
    final result = await _repository.fetchDashboard();
    result.fold(
      (failure) => emit(MiniGameDashboardState.error(failure.message)),
      (dashboard) => emit(
        MiniGameDashboardState.loaded(
          dashboard: dashboard,
          stats: dashboard.stats,
          history: dashboard.recent,
        ),
      ),
    );
  }

  Future<void> loadHistory() async {
    emit(const MiniGameDashboardState.loading());
    final result = await _repository.fetchHistory();
    result.fold(
      (failure) => emit(MiniGameDashboardState.error(failure.message)),
      (history) => emit(MiniGameDashboardState.loaded(history: history)),
    );
  }

  Future<void> loadStats() async {
    emit(const MiniGameDashboardState.loading());
    final result = await _repository.fetchStats();
    result.fold(
      (failure) => emit(MiniGameDashboardState.error(failure.message)),
      (stats) => emit(MiniGameDashboardState.loaded(stats: stats)),
    );
  }
}
