class ApiException implements Exception {
  ApiException({required this.message, this.statusCode, this.details});

  final String message;
  final int? statusCode;
  final Object? details;

  @override
  String toString() {
    final code = statusCode == null ? '' : ' (status: $statusCode)';
    return 'ApiException: $message$code';
  }
}
