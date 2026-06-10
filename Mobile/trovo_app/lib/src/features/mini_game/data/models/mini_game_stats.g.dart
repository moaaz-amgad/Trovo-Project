// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mini_game_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MiniGameStats _$MiniGameStatsFromJson(Map<String, dynamic> json) =>
    _MiniGameStats(
      totalSessions: (_readTotal(json, 'totalSessions') as num?)?.toInt(),
      averageScore: _readAvgScore(json, 'averageScore') as num?,
      averageAccuracy: _readAvgAccuracy(json, 'averageAccuracy') as num?,
      averageReactionTimeMs:
          _readAvgReaction(json, 'averageReactionTimeMs') as num?,
      bestScore: _readBestScore(json, 'bestScore') as num?,
    );

Map<String, dynamic> _$MiniGameStatsToJson(_MiniGameStats instance) =>
    <String, dynamic>{
      'totalSessions': instance.totalSessions,
      'averageScore': instance.averageScore,
      'averageAccuracy': instance.averageAccuracy,
      'averageReactionTimeMs': instance.averageReactionTimeMs,
      'bestScore': instance.bestScore,
    };
