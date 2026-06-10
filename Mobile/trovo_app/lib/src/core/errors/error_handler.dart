import 'dart:io';

import 'package:dio/dio.dart';

import '../../../generated/l10n.dart';
import 'failures.dart';

abstract final class ErrorHandler {
  static Failure handle(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => TimeoutFailure(
        message: S.current.timeoutError,
      ),

      DioExceptionType.connectionError => _handleConnectionError(exception),

      DioExceptionType.cancel => CancelledFailure(
        message: S.current.cancelledError,
      ),

      DioExceptionType.badResponse => _handleBadResponse(exception),

      DioExceptionType.badCertificate => ServerFailure(
        message: S.current.serverError,
      ),

      DioExceptionType.unknown => _handleUnknownError(exception),
    };
  }

  static Failure _handleConnectionError(DioException exception) {
    return NetworkFailure(message: S.current.networkError);
  }

  static Failure _handleUnknownError(DioException exception) {
    if (exception.error is SocketException) {
      return NetworkFailure(message: S.current.networkError);
    }
    return UnknownFailure(message: exception.message ?? S.current.unknownError);
  }

  static Failure _handleBadResponse(DioException exception) {
    final statusCode = exception.response?.statusCode;
    final data = exception.response?.data;

    final message = _extractMessage(data);
    final errors = _extractErrors(data);

    if (statusCode == null) {
      return UnknownFailure(
        message: message.isNotEmpty ? message : S.current.unknownError,
      );
    }

    return switch (statusCode) {
      400 => BadRequestFailure(
        message: message.isNotEmpty ? message : S.current.badRequestError,
        statusCode: statusCode,
      ),
      401 => UnauthorizedFailure(
        message: message.isNotEmpty ? message : S.current.unauthorizedError,
      ),
      403 => _handleForbidden(data, message),
      404 => NotFoundFailure(
        message: message.isNotEmpty ? message : S.current.notFoundError,
      ),
      422 => ValidationFailure(
        message: message.isNotEmpty ? message : S.current.validationError,
        errors: errors,
      ),
      >= 500 => ServerFailure(
        message: message.isNotEmpty ? message : S.current.serverError,
        statusCode: statusCode,
      ),
      _ => UnknownFailure(
        message: message.isNotEmpty ? message : S.current.unknownError,
        statusCode: statusCode,
      ),
    };
  }

  static Failure _handleForbidden(dynamic data, String message) {
    if (data is Map<String, dynamic> &&
        data['status'] == 'email_not_verified') {
      return EmailNotVerifiedFailure(
        message: message,
        email: data['email'] as String? ?? '',
      );
    }
    return ForbiddenFailure(
      message: message.isNotEmpty ? message : S.current.forbiddenError,
    );
  }

  static String _extractMessage(dynamic data) {
    if (data == null) return '';
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ?? '';
    }
    return '';
  }

  static Map<String, dynamic>? _extractErrors(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['errors'] as Map<String, dynamic>?;
    }
    return null;
  }
}
