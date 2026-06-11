import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_summary.freezed.dart';
part 'progress_summary.g.dart';

Object? _readTotalDiagnoses(Map json, String key) =>
    json['total_diagnoses'] ?? json['totalDiagnoses'] ?? json['total_sessions'] ?? json['totalSessions'] ?? 0;

Object? _readCurrentLevel(Map json, String key) =>
    json['current_level'] ?? json['currentLevel'] ?? json['addiction_level'] ?? json['overall_score'] ?? json['overallScore'];

Object? _readCurrentStage(Map json, String key) =>
    json['current_stage'] ?? json['currentStage'] ?? json['brainrot_stage'];

Object? _readOverallChange(Map json, String key) =>
    json['overall_change'] ?? json['overallChange'];

Object? _readCurrentTrend(Map json, String key) =>
    json['current_trend'] ?? json['currentTrend'] ?? json['trend'];

Object? _readStreakDays(Map json, String key) =>
    json['streak_days'] ?? json['streakDays'] ?? json['streak'] ?? json['current_streak'] ?? json['day_streak'] ?? 0;

Object? _readLastDiagnosedAt(Map json, String key) =>
    json['last_diagnosed_at'] ?? json['lastDiagnosedAt'] ?? json['updated_at'] ?? json['updatedAt'];

/// Aggregated progress snapshot from `GET /api/progress`.
@freezed
abstract class ProgressSummary with _$ProgressSummary {
  const factory ProgressSummary({
    @JsonKey(readValue: _readTotalDiagnoses) @Default(0) int totalDiagnoses,
    @JsonKey(readValue: _readCurrentLevel) num? currentLevel,
    @JsonKey(readValue: _readCurrentStage) String? currentStage,
    @JsonKey(readValue: _readOverallChange) num? overallChange,
    @JsonKey(readValue: _readCurrentTrend) String? currentTrend,
    @JsonKey(readValue: _readStreakDays) @Default(0) int streakDays,
    @JsonKey(readValue: _readLastDiagnosedAt) String? lastDiagnosedAt,
  }) = _ProgressSummary;

  // Keep backward-compatible getters
  const ProgressSummary._();

  /// Maps to old `overallScore` accessor for widgets
  num? get overallScore => currentLevel;
  /// Maps to old `totalSessions` accessor
  int? get totalSessions => totalDiagnoses;
  /// Maps to old `streak` accessor
  int? get streak => streakDays;

  factory ProgressSummary.fromJson(Map<String, dynamic> json) =>
      _$ProgressSummaryFromJson(json);

  factory ProgressSummary.fromEnvelope(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map<String, dynamic>) return ProgressSummary.fromJson(data);
    return ProgressSummary.fromJson(json);
  }
}
