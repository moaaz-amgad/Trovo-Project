import 'package:dio/dio.dart';

import '../../../../core/network/endpoints.dart';
import '../models/diagnosis_response.dart';

abstract class DiagnosisRemoteDataSource {
  Future<DiagnosisResponse> generateDiagnosis();
  Future<DiagnosisResponse> fetchHistory();
}

class DiagnosisRemoteDataSourceImpl implements DiagnosisRemoteDataSource {
  final Dio _dio;

  DiagnosisRemoteDataSourceImpl(this._dio);

  @override
  Future<DiagnosisResponse> generateDiagnosis() async {
    final response = await _dio.post(Endpoints.generateDiagnosis);
    return DiagnosisResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<DiagnosisResponse> fetchHistory() async {
    final response = await _dio.get(Endpoints.diagnosisHistory);
    return DiagnosisResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
