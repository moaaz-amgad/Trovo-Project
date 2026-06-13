import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_entry.freezed.dart';
part 'progress_entry.g.dart';

Object? _readScore(Map json, String key) {
  if (json['diagnosis'] != null && json['diagnosis']['addiction_level'] != null) {
    return json['diagnosis']['addiction_level'];
  }
  return json['score'] ?? json['overall_score'] ?? json['value'];
}

Object? _readDate(Map json, String key) {
  return json['tracked_at'] ?? json['date'] ?? json['created_at'] ?? json['createdAt'];
}

Object? _readLabel(Map json, String key) {
  if (json['diagnosis'] != null && json['diagnosis']['brainrot_stage'] != null) {
    return json['diagnosis']['brainrot_stage'];
  }
  return json['label'] ?? json['title'] ?? json['feature'];
}

/// A single progress-tracking point from `GET /api/progress/history`.
@freezed
abstract class ProgressEntry with _$ProgressEntry {
  const factory ProgressEntry({
    int? id,
    @JsonKey(readValue: _readScore) num? score,
    @JsonKey(readValue: _readDate) String? date,
    @JsonKey(readValue: _readLabel) String? label,
  }) = _ProgressEntry;

  factory ProgressEntry.fromJson(Map<String, dynamic> json) =>
      _$ProgressEntryFromJson(json);

  static List<ProgressEntry> listFromEnvelope(dynamic json) {
    dynamic list = json is Map<String, dynamic>
        ? (json['data'] ?? json['history'] ?? json['records'])
        : json;
        
    // Handle Laravel pagination where 'data' contains { current_page: 1, data: [...] }
    if (list is Map<String, dynamic> && list.containsKey('data')) {
      list = list['data'];
    }

    if (list is List) {
      return list
          .whereType<Map<String, dynamic>>()
          .map(ProgressEntry.fromJson)
          .toList();
    }
    return const [];
  }
}
