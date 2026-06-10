import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/user_profile.dart';
import '../../data/repositories/user_repository.dart';

part 'user_cubit.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _UserInitial;
  const factory UserState.loading() = _UserLoading;
  const factory UserState.loaded(UserProfile profile) = _UserLoaded;
  const factory UserState.actionInProgress(UserProfile? profile) =
      _UserActionInProgress;
  const factory UserState.actionSuccess({
    UserProfile? profile,
    required String message,
  }) = _UserActionSuccess;
  const factory UserState.accountDeleted(String message) = _UserAccountDeleted;
  const factory UserState.error(String message) = _UserError;
}

class UserCubit extends Cubit<UserState> {
  final UserRepository _repository;

  UserCubit({required UserRepository repository})
    : _repository = repository,
      super(const UserState.initial());

  UserProfile? _profile;

  UserProfile? get profile => _profile;

  Future<void> loadProfile() async {
    emit(const UserState.loading());
    final result = await _repository.getProfile();
    result.fold((failure) => emit(UserState.error(failure.message)), (profile) {
      _profile = profile;
      emit(UserState.loaded(profile));
    });
  }

  Future<void> updateProfile({String? name, String? avatar}) async {
    emit(UserState.actionInProgress(_profile));
    final result = await _repository.updateProfile(name: name, avatar: avatar);
    result.fold((failure) => emit(UserState.error(failure.message)), (profile) {
      _profile = profile;
      emit(
        UserState.actionSuccess(
          profile: profile,
          message: 'Profile updated',
        ),
      );
    });
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(UserState.actionInProgress(_profile));
    final result = await _repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    result.fold(
      (failure) => emit(UserState.error(failure.message)),
      (message) =>
          emit(UserState.actionSuccess(profile: _profile, message: message)),
    );
  }

  Future<void> deleteAccount() async {
    emit(UserState.actionInProgress(_profile));
    final result = await _repository.deleteAccount();
    result.fold(
      (failure) => emit(UserState.error(failure.message)),
      (message) => emit(UserState.accountDeleted(message)),
    );
  }
}
