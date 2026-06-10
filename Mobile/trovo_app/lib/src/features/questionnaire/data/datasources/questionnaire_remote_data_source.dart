import 'package:dio/dio.dart';

import '../../../../core/network/endpoints.dart';

abstract class QuestionnaireRemoteDataSource {
  Future<Map<String, dynamic>> submitResponses(Map<String, String> fields);
  Future<Map<String, dynamic>> fetchHistory();
}

class QuestionnaireRemoteDataSourceImpl
    implements QuestionnaireRemoteDataSource {
  final Dio _dio;

  QuestionnaireRemoteDataSourceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> submitResponses(
    Map<String, String> fields,
  ) async {
    final response = await _dio.post(
      Endpoints.submitQuestionnaire,
      data: FormData.fromMap(fields),
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> fetchHistory() async {
    final response = await _dio.get(Endpoints.questionnaireHistory);
    return response.data as Map<String, dynamic>;
  }
}
