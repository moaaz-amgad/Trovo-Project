// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProgressEntry _$ProgressEntryFromJson(Map<String, dynamic> json) =>
    _ProgressEntry(
      id: (json['id'] as num?)?.toInt(),
      score: _readScore(json, 'score') as num?,
      date: _readDate(json, 'date') as String?,
      label: _readLabel(json, 'label') as String?,
    );

Map<String, dynamic> _$ProgressEntryToJson(_ProgressEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'score': instance.score,
      'date': instance.date,
      'label': instance.label,
    };
