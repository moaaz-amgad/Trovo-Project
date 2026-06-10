import 'package:dio/dio.dart';

class LanguageInterceptor extends Interceptor {
  String _languageCode = 'ar';

  void updateLanguage(String languageCode) {
    _languageCode = languageCode;
  }

  String get currentLanguage => _languageCode;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] = _languageCode;
    handler.next(options);
  }
}
