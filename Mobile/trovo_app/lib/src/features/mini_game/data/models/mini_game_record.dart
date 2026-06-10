import 'package:freezed_annotation/freezed_annotation.dart';

part 'mini_game_record.freezed.dart';
part 'mini_game_record.g.dart';

Object? _readGameType(Map json, String key) =>
    json['game_type'] ?? json['gameType'] ?? json['type'];

Object? _readReaction(Map json, String key) =>
    json['reaction_time_ms'] ?? json['reactionTimeMs'];

Object? _readAccuracy(Map json, String key) =>
    json['accuracy_percentage'] ?? json['accuracyPercentage'] ?? json['accuracy'];

Object? _readDifficulty(Map json, String key) =>
    json['difficulty_level'] ?? json['difficultyLevel'] ?? json['level'];

Object? _readDuration(Map json, String key) =>
    json['duration_seconds'] ?? json['durationSeconds'];

Object? _readCreatedAt(Map json, String key) =>
    json['created_at'] ?? json['createdAt'];

/// A single mini-game session as returned by the submit/history endpoints.
@freezed
abstract class MiniGameRecord with _$MiniGameRecord {
  const factory MiniGameRecord({
    int? id,
    @JsonKey(readValue: _readGameType) String? gameType,
    num? score,
    @JsonKey(readValue: _readReaction) num? reactionTimeMs,
    @JsonKey(readValue: _readAccuracy) num? accuracyPercentage,
    @JsonKey(readValue: _readDifficulty) String? difficultyLevel,
    @JsonKey(readValue: _readDuration) num? durationSeconds,
    @JsonKey(readValue: _readCreatedAt) String? createdAt,
  }) = _MiniGameRecord;

  factory MiniGameRecord.fromJson(Map<String, dynamic> json) =>
      _$MiniGameRecordFromJson(json);

  /// Reads a list of records from a `{ data: [...] }` or bare list envelope.
  static List<MiniGameRecord> listFromEnvelope(dynamic json) {
    final dynamic list = json is Map<String, dynamic>
        ? (json['data'] ?? json['records'] ?? json['history'])
        : json;
    if (list is List) {
      return list
          .whereType<Map<String, dynamic>>()
          .map(MiniGameRecord.fromJson)
          .toList();
    }
    return const [];
  }
}
