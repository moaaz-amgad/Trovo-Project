// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mini_game_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MiniGameRecord _$MiniGameRecordFromJson(Map<String, dynamic> json) =>
    _MiniGameRecord(
      id: (json['id'] as num?)?.toInt(),
      gameType: _readGameType(json, 'gameType') as String?,
      score: json['score'] as num?,
      reactionTimeMs: _readReaction(json, 'reactionTimeMs') as num?,
      accuracyPercentage: _readAccuracy(json, 'accuracyPercentage') as num?,
      difficultyLevel: _readDifficulty(json, 'difficultyLevel') as String?,
      durationSeconds: _readDuration(json, 'durationSeconds') as num?,
      createdAt: _readCreatedAt(json, 'createdAt') as String?,
    );

Map<String, dynamic> _$MiniGameRecordToJson(_MiniGameRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gameType': instance.gameType,
      'score': instance.score,
      'reactionTimeMs': instance.reactionTimeMs,
      'accuracyPercentage': instance.accuracyPercentage,
      'difficultyLevel': instance.difficultyLevel,
      'durationSeconds': instance.durationSeconds,
      'createdAt': instance.createdAt,
    };
