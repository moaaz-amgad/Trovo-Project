import 'package:dio/dio.dart';

import '../../../../core/network/endpoints.dart';
import '../models/mini_game_dashboard.dart';
import '../models/mini_game_record.dart';
import '../models/mini_game_session.dart';
import '../models/mini_game_stats.dart';

abstract class MiniGameRemoteDataSource {
  Future<MiniGameRecord> submitSession(MiniGameSession session);
  Future<List<MiniGameRecord>> fetchHistory();
  Future<MiniGameStats> fetchStats();
  Future<MiniGameDashboard> fetchDashboard();
}

class MiniGameRemoteDataSourceImpl implements MiniGameRemoteDataSource {
  final Dio _dio;

  MiniGameRemoteDataSourceImpl(this._dio);

  @override
  Future<MiniGameRecord> submitSession(MiniGameSession session) async {
    final response = await _dio.post(
      Endpoints.submitMiniGame,
      data: FormData.fromMap(session.toFields()),
    );
    final data = response.data;
    final record = data is Map<String, dynamic> ? (data['data'] ?? data) : data;
    return MiniGameRecord.fromJson(record as Map<String, dynamic>);
  }

  @override
  Future<List<MiniGameRecord>> fetchHistory() async {
    final response = await _dio.get(Endpoints.miniGameHistory);
    return MiniGameRecord.listFromEnvelope(response.data);
  }

  @override
  Future<MiniGameStats> fetchStats() async {
    final response = await _dio.get(Endpoints.miniGameStats);
    return MiniGameStats.fromEnvelope(response.data as Map<String, dynamic>);
  }

  @override
  Future<MiniGameDashboard> fetchDashboard() async {
    final response = await _dio.get(Endpoints.miniGameDashboard);
    return MiniGameDashboard.fromJson(response.data as Map<String, dynamic>);
  }
}
