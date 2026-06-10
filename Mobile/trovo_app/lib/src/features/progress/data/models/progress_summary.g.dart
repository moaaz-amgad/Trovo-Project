// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProgressSummary _$ProgressSummaryFromJson(Map<String, dynamic> json) =>
    _ProgressSummary(
      overallScore: _readOverall(json, 'overallScore') as num?,
      totalSessions: (_readSessions(json, 'totalSessions') as num?)?.toInt(),
      streak: (_readStreak(json, 'streak') as num?)?.toInt(),
      focusTimeMinutes: _readFocus(json, 'focusTimeMinutes') as num?,
      updatedAt: _readUpdated(json, 'updatedAt') as String?,
    );

Map<String, dynamic> _$ProgressSummaryToJson(_ProgressSummary instance) =>
    <String, dynamic>{
      'overallScore': instance.overallScore,
      'totalSessions': instance.totalSessions,
      'streak': instance.streak,
      'focusTimeMinutes': instance.focusTimeMinutes,
      'updatedAt': instance.updatedAt,
    };
