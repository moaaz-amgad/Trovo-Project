import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/phone_usage_metrics.dart';

abstract class PhoneUsagePlatformDataSource {
  Future<bool> hasUsageAccess();
  Future<void> openUsageAccessSettings();
  Future<PhoneUsagePlatformResult> fetchUsageData();
}

class PhoneUsagePlatformDataSourceImpl implements PhoneUsagePlatformDataSource {
  static const String channelName = 'trovo_app/phone_usage';
  static const MethodChannel _channel = MethodChannel(channelName);

  @override
  Future<bool> hasUsageAccess() async {
    if (!_isAndroid) return false;
    try {
      final result = await _channel.invokeMethod<bool>('hasUsageAccess');
      return result ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> openUsageAccessSettings() async {
    if (!_isAndroid) return;
    try {
      await _channel.invokeMethod<void>('openUsageAccessSettings');
    } catch (_) {
      return;
    }
  }

  @override
  Future<PhoneUsagePlatformResult> fetchUsageData() async {
    try {
      final raw = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'fetchUsageData',
      );
      if (raw == null) {
        return const PhoneUsagePlatformResult.unavailable(
          'No data returned from platform.',
        );
      }
      return PhoneUsagePlatformResult.fromMap(Map<String, dynamic>.from(raw));
    } catch (error) {
      return PhoneUsagePlatformResult.unavailable(
        'Failed to fetch usage data: $error',
      );
    }
  }

  bool get _isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
}
