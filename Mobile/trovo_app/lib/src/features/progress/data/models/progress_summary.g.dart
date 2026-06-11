// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProgressSummary _$ProgressSummaryFromJson(Map<String, dynamic> json) =>
    _ProgressSummary(
      totalDiagnoses:
          (_readTotalDiagnoses(json, 'totalDiagnoses') as num?)?.toInt() ?? 0,
      currentLevel: _readCurrentLevel(json, 'currentLevel') as num?,
      currentStage: _readCurrentStage(json, 'currentStage') as String?,
      overallChange: _readOverallChange(json, 'overallChange') as num?,
      currentTrend: _readCurrentTrend(json, 'currentTrend') as String?,
      streakDays: (_readStreakDays(json, 'streakDays') as num?)?.toInt() ?? 0,
      lastDiagnosedAt: _readLastDiagnosedAt(json, 'lastDiagnosedAt') as String?,
    );

Map<String, dynamic> _$ProgressSummaryToJson(_ProgressSummary instance) =>
    <String, dynamic>{
      'totalDiagnoses': instance.totalDiagnoses,
      'currentLevel': instance.currentLevel,
      'currentStage': instance.currentStage,
      'overallChange': instance.overallChange,
      'currentTrend': instance.currentTrend,
      'streakDays': instance.streakDays,
      'lastDiagnosedAt': instance.lastDiagnosedAt,
    };
