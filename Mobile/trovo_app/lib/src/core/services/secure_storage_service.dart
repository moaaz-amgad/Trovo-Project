import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/api_constants.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService()
    : _storage = const FlutterSecureStorage(
        aOptions: AndroidOptions(),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

  // ===========================================================================
  // Access & Refresh Token Management
  // ===========================================================================

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(
      key: ApiConstants.accessTokenKey,
      value: accessToken,
    );
    await _storage.write(
      key: ApiConstants.refreshTokenKey,
      value: refreshToken,
    );
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: ApiConstants.accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: ApiConstants.refreshTokenKey);
  }

  Future<void> removeTokens() async {
    await _storage.delete(key: ApiConstants.accessTokenKey);
    await _storage.delete(key: ApiConstants.refreshTokenKey);
  }

  Future<bool> hasAccessToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // ===========================================================================
  // Legacy Token API (backward compatibility)
  // ===========================================================================

  Future<void> saveToken(String token) async {
    await _storage.write(key: ApiConstants.accessTokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await getAccessToken();
  }

  Future<void> removeToken() async {
    await removeTokens();
  }

  Future<bool> hasToken() async {
    return hasAccessToken();
  }

  // ===========================================================================
  // User Data
  // ===========================================================================

  Future<void> saveUserData(String userData) async {
    await _storage.write(key: ApiConstants.userKey, value: userData);
  }

  Future<String?> getUserData() async {
    return await _storage.read(key: ApiConstants.userKey);
  }

  Future<void> removeUserData() async {
    await _storage.delete(key: ApiConstants.userKey);
  }

  // ===========================================================================
  // Generic Operations
  // ===========================================================================

  Future<void> save(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }
}
