import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/login_response.dart';
import '../../data/models/register_response.dart';
import '../../data/repositories/auth_repository.dart';

part 'auth_cubit.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _AuthInitial;
  const factory AuthState.loading() = _AuthLoading;
  const factory AuthState.loginSuccess(LoginResponse data) = _AuthLoginSuccess;
  const factory AuthState.registerSuccess(RegisterResponse data) =
      _AuthRegisterSuccess;
  const factory AuthState.verifyEmailSuccess(String message) =
      _AuthVerifyEmailSuccess;
  const factory AuthState.otpResentSuccess(String message) =
      _AuthOtpResentSuccess;
  const factory AuthState.forgotPasswordSuccess({
    required String email,
    required String message,
  }) = _AuthForgotPasswordSuccess;
  const factory AuthState.resetPasswordSuccess(String message) =
      _AuthResetPasswordSuccess;
  const factory AuthState.emailNotVerified(String email) =
      _AuthEmailNotVerified;
  const factory AuthState.error(String message) = _AuthError;
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit({required AuthRepository repository})
    : _repository = repository,
      super(const AuthState.initial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());
    final result = await _repository.login(email: email, password: password);
    result.fold(
      (failure) {
        if (failure is EmailNotVerifiedFailure) {
          emit(AuthState.emailNotVerified(failure.email));
        } else {
          emit(AuthState.error(failure.message));
        }
      },
      (response) => emit(AuthState.loginSuccess(response)),
    );
  }

  Future<void> googleLogin({required String idToken}) async {
    emit(const AuthState.loading());
    final result = await _repository.googleLogin(idToken: idToken);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (response) => emit(AuthState.loginSuccess(response)),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());
    final result = await _repository.register(
      name: name,
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (response) => emit(AuthState.registerSuccess(response)),
    );
  }

  Future<void> verifyEmail({
    required String email,
    required String code,
  }) async {
    emit(const AuthState.loading());
    final result = await _repository.verifyEmail(email: email, code: code);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (response) => emit(
        AuthState.verifyEmailSuccess(
          response.message.isEmpty ? 'Email verified' : response.message,
        ),
      ),
    );
  }

  Future<void> resendOtp({
    required String email,
    String type = 'email_verification',
  }) async {
    final result = await _repository.resendOtp(email: email, type: type);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (response) => emit(
        AuthState.otpResentSuccess(
          response.message.isEmpty ? 'Code sent again' : response.message,
        ),
      ),
    );
  }

  Future<void> forgotPassword({required String email}) async {
    emit(const AuthState.loading());
    final result = await _repository.forgotPassword(email: email);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (response) => emit(
        AuthState.forgotPasswordSuccess(
          email: email,
          message: response.message,
        ),
      ),
    );
  }

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    emit(const AuthState.loading());
    final result = await _repository.resetPassword(
      email: email,
      code: code,
      newPassword: newPassword,
    );
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (response) => emit(AuthState.resetPasswordSuccess(response.message)),
    );
  }

  Future<void> logout() async {
    await _repository.logout();
    emit(const AuthState.initial());
  }
}
