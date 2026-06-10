import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/user_profile.dart';

abstract class UserRepository {
  Future<Either<Failure, UserProfile>> getProfile();

  Future<Either<Failure, UserProfile>> updateProfile({
    String? name,
    String? avatar,
  });

  Future<Either<Failure, String>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<Either<Failure, String>> deleteAccount();
}
