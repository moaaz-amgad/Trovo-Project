import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/phone_usage_data.dart';
import '../models/phone_usage_metrics.dart';

abstract class PhoneUsageRepository {
  Future<Either<Failure, Map<String, dynamic>>> submitUsage(
    Map<String, String> fields,
  );

  Future<Either<Failure, Map<String, dynamic>>> submitUsageData(
    PhoneUsageData data,
  );

  Future<Either<Failure, Map<String, dynamic>>> fetchHistory();

  Future<bool> hasUsageAccess();
  Future<void> openUsageAccessSettings();
  Future<PhoneUsagePlatformResult> fetchPlatformUsageData();
}
