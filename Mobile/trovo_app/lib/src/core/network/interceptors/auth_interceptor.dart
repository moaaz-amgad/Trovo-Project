import 'package:dio/dio.dart';

import '../../constants/api_constants.dart';
import '../../services/secure_storage_service.dart';
import '../endpoints.dart';

class AuthInterceptor extends QueuedInterceptor {
  final SecureStorageService _secureStorage;
  final Dio _dio;

  AuthInterceptor(this._secureStorage, this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers[ApiConstants.authorizationHeader] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await _secureStorage.getRefreshToken();

        if (refreshToken == null || refreshToken.isEmpty) {
          await _secureStorage.removeTokens();
          await _secureStorage.removeUserData();
          return handler.next(err);
        }

        // Attempt to refresh token
        final response = await _dio.post(
          Endpoints.refreshToken,
          options: Options(
            headers: {ApiConstants.refreshTokenHeader: refreshToken},
          ),
        );

        final responseData = response.data;
        final root = responseData is Map<String, dynamic>
            ? responseData
            : <String, dynamic>{};
        final nestedData = root['data'] is Map<String, dynamic>
            ? root['data'] as Map<String, dynamic>
            : <String, dynamic>{};

        final newAccessToken =
            (root['accessToken'] ?? nestedData['accessToken']) as String?;
        final newRefreshToken =
            (root['refreshToken'] ?? nestedData['refreshToken']) as String? ??
            refreshToken;

        if (newAccessToken == null || newAccessToken.isEmpty) {
          await _secureStorage.removeTokens();
          await _secureStorage.removeUserData();
          return handler.next(err);
        }

        // Save new tokens
        await _secureStorage.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );

        // Retry original request
        final request = err.requestOptions;
        request.headers[ApiConstants.authorizationHeader] =
            'Bearer $newAccessToken';

        final retryResponse = await _dio.fetch(request);
        return handler.resolve(retryResponse);
      } catch (e) {
        // Refresh failed — clear auth and proceed
        await _secureStorage.removeTokens();
        await _secureStorage.removeUserData();
      }
    }

    handler.next(err);
  }
}
