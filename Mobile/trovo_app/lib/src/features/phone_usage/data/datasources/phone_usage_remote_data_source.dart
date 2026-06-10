import 'package:dio/dio.dart';

import '../../../../core/network/endpoints.dart';
import '../models/phone_usage_data.dart';

abstract class PhoneUsageRemoteDataSource {
  Future<Map<String, dynamic>> submitUsage(Map<String, String> fields);
  Future<Map<String, dynamic>> submitUsageData(PhoneUsageData data);
  Future<Map<String, dynamic>> fetchHistory();
}

class PhoneUsageRemoteDataSourceImpl implements PhoneUsageRemoteDataSource {
  final Dio _dio;

  PhoneUsageRemoteDataSourceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> submitUsage(Map<String, String> fields) async {
    final response = await _dio.post(
      Endpoints.submitPhoneUsage,
      data: FormData.fromMap(fields),
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> submitUsageData(PhoneUsageData data) {
    return submitUsage(data.toFormFields());
  }

  @override
  Future<Map<String, dynamic>> fetchHistory() async {
    final response = await _dio.get(Endpoints.phoneUsageHistory);
    return response.data as Map<String, dynamic>;
  }
}
