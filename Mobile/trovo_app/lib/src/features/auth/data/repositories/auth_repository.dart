import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/auth_action_response.dart';
import '../models/login_response.dart';
import '../models/register_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, LoginResponse>> googleLogin({
    required String idToken,
  });

  Future<Either<Failure, RegisterResponse>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthActionResponse>> verifyEmail({
    required String email,
    required String code,
  });

  Future<Either<Failure, AuthActionResponse>> resendOtp({
    required String email,
    String type,
  });

  Future<Either<Failure, AuthActionResponse>> forgotPassword({
    required String email,
  });

  Future<Either<Failure, AuthActionResponse>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  });

  Future<Either<Failure, Unit>> logout();
}
