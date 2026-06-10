import 'package:freezed_annotation/freezed_annotation.dart';

part 'mini_game_stats.freezed.dart';
part 'mini_game_stats.g.dart';

Object? _readTotal(Map json, String key) =>
    json['total_sessions'] ?? json['totalSessions'] ?? json['total_games'] ??
    json['count'];

Object? _readAvgScore(Map json, String key) =>
    json['average_score'] ?? json['averageScore'] ?? json['avg_score'];

Object? _readAvgAccuracy(Map json, String key) =>
    json['average_accuracy'] ??
    json['averageAccuracy'] ??
    json['avg_accuracy'];

Object? _readAvgReaction(Map json, String key) =>
    json['average_reaction_time_ms'] ??
    json['averageReactionTimeMs'] ??
    json['avg_reaction_time_ms'];

Object? _readBestScore(Map json, String key) =>
    json['best_score'] ?? json['bestScore'] ?? json['highest_score'];

/// Aggregate mini-game statistics from `GET /api/mini-game/stats`.
///
/// Fields are intentionally tolerant of the exact server key names so the
/// model survives small backend contract differences.
@freezed
abstract class MiniGameStats with _$MiniGameStats {
  const factory MiniGameStats({
    @JsonKey(readValue: _readTotal) int? totalSessions,
    @JsonKey(readValue: _readAvgScore) num? averageScore,
    @JsonKey(readValue: _readAvgAccuracy) num? averageAccuracy,
    @JsonKey(readValue: _readAvgReaction) num? averageReactionTimeMs,
    @JsonKey(readValue: _readBestScore) num? bestScore,
  }) = _MiniGameStats;

  factory MiniGameStats.fromJson(Map<String, dynamic> json) =>
      _$MiniGameStatsFromJson(json);

  /// Unwraps a `{ data: {...} }` envelope when present.
  factory MiniGameStats.fromEnvelope(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map<String, dynamic>) return MiniGameStats.fromJson(data);
    return MiniGameStats.fromJson(json);
  }
}
