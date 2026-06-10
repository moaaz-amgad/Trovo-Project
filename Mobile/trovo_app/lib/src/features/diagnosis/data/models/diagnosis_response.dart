import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagnosis_response.freezed.dart';
part 'diagnosis_response.g.dart';

@freezed
abstract class DiagnosisResponse with _$DiagnosisResponse {
  const factory DiagnosisResponse({
    @Default('') String status,
    @Default('') String message,
    Map<String, dynamic>? data,
    Object? errors,
  }) = _DiagnosisResponse;

  factory DiagnosisResponse.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisResponseFromJson(json);
}
