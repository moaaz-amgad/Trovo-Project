import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/phone_usage_data.dart';
import '../../data/models/phone_usage_metrics.dart';
import '../../data/repositories/phone_usage_repository.dart';

part 'phone_usage_cubit.freezed.dart';

@freezed
class PhoneUsageState with _$PhoneUsageState {
  const factory PhoneUsageState.initial() = _PhoneUsageInitial;
  const factory PhoneUsageState.loading() = _PhoneUsageLoading;
  const factory PhoneUsageState.permissionRequired(String message) =
      _PhoneUsagePermissionRequired;
  const factory PhoneUsageState.metricsLoaded(PhoneUsageMetrics metrics) =
      _PhoneUsageMetricsLoaded;
  const factory PhoneUsageState.submitted(Map<String, dynamic> data) =
      _PhoneUsageSubmitted;
  const factory PhoneUsageState.error(String message) = _PhoneUsageError;
}

class PhoneUsageCubit extends Cubit<PhoneUsageState> {
  final PhoneUsageRepository _repository;

  PhoneUsageCubit({required PhoneUsageRepository repository})
    : _repository = repository,
      super(const PhoneUsageState.initial());

  Future<bool> hasUsageAccess() => _repository.hasUsageAccess();

  Future<void> openUsageAccessSettings() =>
      _repository.openUsageAccessSettings();

  Future<void> loadPlatformUsage() async {
    emit(const PhoneUsageState.loading());
    final hasAccess = await _repository.hasUsageAccess();
    if (!hasAccess) {
      emit(
        const PhoneUsageState.permissionRequired(
          'Usage access permission is required.',
        ),
      );
      return;
    }
    final result = await _repository.fetchPlatformUsageData();
    if (!result.isAvailable || result.metrics == null) {
      emit(
        PhoneUsageState.error(
          result.message ?? 'Failed to fetch usage data.',
        ),
      );
      return;
    }
    emit(PhoneUsageState.metricsLoaded(result.metrics!));
  }

  Future<void> submitUsageData(PhoneUsageData data) async {
    emit(const PhoneUsageState.loading());
    final result = await _repository.submitUsageData(data);
    result.fold(
      (failure) => emit(PhoneUsageState.error(failure.message)),
      (response) => emit(PhoneUsageState.submitted(response)),
    );
  }

  Future<void> submitUsage(Map<String, String> fields) async {
    emit(const PhoneUsageState.loading());
    final result = await _repository.submitUsage(fields);
    result.fold(
      (failure) => emit(PhoneUsageState.error(failure.message)),
      (response) => emit(PhoneUsageState.submitted(response)),
    );
  }
}
