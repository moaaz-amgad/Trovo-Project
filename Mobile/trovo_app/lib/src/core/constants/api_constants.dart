/// API Constants
class ApiConstants {
  ApiConstants._();

  /// Toggle this to work on UI flows without hitting backend APIs.
  static const bool enableApiIntegration = true;

  /// Base URL
  /// To fix the WiFi issue, run `ngrok http 8000` and put the URL here.
  /// Example: 'https://1a2b-3c4d.ngrok-free.app'
  static const String baseUrl = 'https://brandy-bronzelike-lai.ngrok-free.dev';

  /// Timeouts
  static const Duration connectTimeout = Duration(seconds: 60);
  static const Duration receiveTimeout = Duration(seconds: 60);
  static const Duration sendTimeout = Duration(seconds: 60);

  /// Headers
  static const String acceptHeader = 'Accept';
  static const String contentTypeHeader = 'Content-Type';
  static const String authorizationHeader = 'Authorization';
  static const String refreshTokenHeader = 'refreshtoken';
  static const String applicationJson = 'application/json';
  static const String multipartFormData = 'multipart/form-data';

  /// Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String languageKey = 'app_language';

  /// Legacy keys (for migration)
  static const String tokenKey = accessTokenKey;
}
