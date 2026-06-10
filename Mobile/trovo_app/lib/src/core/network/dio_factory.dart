import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/api_constants.dart';
import '../services/secure_storage_service.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/language_interceptor.dart';

class DioFactory {
  DioFactory._();

  static LanguageInterceptor? _languageInterceptor;

  static LanguageInterceptor get languageInterceptor {
    _languageInterceptor ??= LanguageInterceptor();
    return _languageInterceptor!;
  }

  static Dio create(SecureStorageService secureStorage) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        headers: {ApiConstants.acceptHeader: ApiConstants.applicationJson},
      ),
    );

    dio.interceptors.addAll([
      languageInterceptor,
      AuthInterceptor(secureStorage, dio),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    ]);

    return dio;
  }
}
