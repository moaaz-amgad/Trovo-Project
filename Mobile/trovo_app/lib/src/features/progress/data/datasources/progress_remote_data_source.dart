import 'package:dio/dio.dart';

import '../../../../core/network/endpoints.dart';
import '../models/progress_entry.dart';
import '../models/progress_summary.dart';

abstract class ProgressRemoteDataSource {
  Future<ProgressSummary> fetchSummary();
  Future<List<ProgressEntry>> fetchHistory();
}

class ProgressRemoteDataSourceImpl implements ProgressRemoteDataSource {
  final Dio _dio;

  ProgressRemoteDataSourceImpl(this._dio);

  @override
  Future<ProgressSummary> fetchSummary() async {
    final response = await _dio.get(Endpoints.progress);
    return ProgressSummary.fromEnvelope(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<ProgressEntry>> fetchHistory() async {
    final response = await _dio.get(Endpoints.progressHistory);
    return ProgressEntry.listFromEnvelope(response.data);
  }
}
