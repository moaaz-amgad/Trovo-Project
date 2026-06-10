import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String message;

  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];

  @override
  String toString() => 'Failure(message: $message, statusCode: $statusCode)';
}

final class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.statusCode});
}

final class TimeoutFailure extends Failure {
  const TimeoutFailure({required super.message, super.statusCode});
}

final class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message, super.statusCode = 404});
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({required super.message, super.statusCode = 401});
}

final class ForbiddenFailure extends Failure {
  const ForbiddenFailure({required super.message, super.statusCode = 403});
}

final class BadRequestFailure extends Failure {
  const BadRequestFailure({required super.message, super.statusCode = 400});
}

final class ValidationFailure extends Failure {
  final Map<String, dynamic>? errors;

  const ValidationFailure({
    required super.message,
    super.statusCode = 422,
    this.errors,
  });

  String? getFieldError(String field) {
    if (errors == null) return null;
    final fieldErrors = errors![field];
    if (fieldErrors is List && fieldErrors.isNotEmpty) {
      return fieldErrors.first.toString();
    }
    return fieldErrors?.toString();
  }

  String get allErrorsAsString {
    if (errors == null || errors!.isEmpty) return message;

    return errors!.entries
        .map((e) => e.value is List ? (e.value as List).join(', ') : e.value)
        .join('\n');
  }

  @override
  List<Object?> get props => [message, statusCode, errors];
}

final class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.statusCode});
}

final class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.statusCode});
}

final class CancelledFailure extends Failure {
  const CancelledFailure({required super.message, super.statusCode});
}

final class EmailNotVerifiedFailure extends Failure {
  final String email;

  const EmailNotVerifiedFailure({
    required super.message,
    required this.email,
    super.statusCode = 403,
  });

  @override
  List<Object?> get props => [message, statusCode, email];
}
