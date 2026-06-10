import 'package:hive_flutter/hive_flutter.dart';

class CacheKeys {
  CacheKeys._();

  static const String generalBox = 'general_box';
  static const String authBox = 'auth_box';
  static const String authToken = 'auth_token';
}

class HiveCacheService {
  static final HiveCacheService _instance = HiveCacheService._internal();
  factory HiveCacheService() => _instance;
  HiveCacheService._internal();

  late Box _generalBox;
  late Box _authBox;
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    await Hive.initFlutter();
    _generalBox = await Hive.openBox(CacheKeys.generalBox);
    _authBox = await Hive.openBox(CacheKeys.authBox);
    _isInitialized = true;
  }

  // ============================================================================
  // Token Management
  // ============================================================================

  Future<void> cacheToken(String token) async {
    await _authBox.put(CacheKeys.authToken, token);
  }

  String? getCachedToken() {
    return _authBox.get(CacheKeys.authToken) as String?;
  }

  Future<void> removeToken() async {
    await _authBox.delete(CacheKeys.authToken);
  }

  bool hasToken() {
    final token = getCachedToken();
    return token != null && token.isNotEmpty;
  }

  // ============================================================================
  // Generic Cache Operations
  // ============================================================================

  Future<void> put(String key, dynamic value) async {
    await _generalBox.put(key, value);
  }

  dynamic get(String key) {
    return _generalBox.get(key);
  }

  Future<void> remove(String key) async {
    await _generalBox.delete(key);
  }

  bool containsKey(String key) {
    return _generalBox.containsKey(key);
  }

  // ============================================================================
  // Clear Operations
  // ============================================================================

  Future<void> clearAll() async {
    await _generalBox.clear();
    await _authBox.clear();
  }

  Future<void> clearGeneralCache() async {
    await _generalBox.clear();
  }
}
