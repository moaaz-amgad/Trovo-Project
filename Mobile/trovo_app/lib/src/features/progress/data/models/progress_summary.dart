import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_summary.freezed.dart';
part 'progress_summary.g.dart';

Object? _readOverall(Map json, String key) =>
    json['overall_score'] ?? json['overallScore'] ?? json['score'];

Object? _readSessions(Map json, String key) =>
    json['total_sessions'] ?? json['totalSessions'] ?? json['sessions'];

Object? _readStreak(Map json, String key) =>
    json['streak'] ?? json['current_streak'] ?? json['day_streak'];

Object? _readFocus(Map json, String key) =>
    json['focus_time_minutes'] ?? json['focusTimeMinutes'] ?? json['focus_time'];

Object? _readUpdated(Map json, String key) =>
    json['updated_at'] ?? json['updatedAt'] ?? json['last_updated'];

/// Aggregated progress snapshot from `GET /api/progress`.
@freezed
abstract class ProgressSummary with _$ProgressSummary {
  const factory ProgressSummary({
    @JsonKey(readValue: _readOverall) num? overallScore,
    @JsonKey(readValue: _readSessions) int? totalSessions,
    @JsonKey(readValue: _readStreak) int? streak,
    @JsonKey(readValue: _readFocus) num? focusTimeMinutes,
    @JsonKey(readValue: _readUpdated) String? updatedAt,
  }) = _ProgressSummary;

  factory ProgressSummary.fromJson(Map<String, dynamic> json) =>
      _$ProgressSummaryFromJson(json);

  factory ProgressSummary.fromEnvelope(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map<String, dynamic>) return ProgressSummary.fromJson(data);
    return ProgressSummary.fromJson(json);
  }
}
