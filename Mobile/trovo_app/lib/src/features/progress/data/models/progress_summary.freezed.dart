// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProgressSummary {

@JsonKey(readValue: _readTotalDiagnoses) int get totalDiagnoses;@JsonKey(readValue: _readCurrentLevel) num? get currentLevel;@JsonKey(readValue: _readCurrentStage) String? get currentStage;@JsonKey(readValue: _readOverallChange) num? get overallChange;@JsonKey(readValue: _readCurrentTrend) String? get currentTrend;@JsonKey(readValue: _readStreakDays) int get streakDays;@JsonKey(readValue: _readLastDiagnosedAt) String? get lastDiagnosedAt;
/// Create a copy of ProgressSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressSummaryCopyWith<ProgressSummary> get copyWith => _$ProgressSummaryCopyWithImpl<ProgressSummary>(this as ProgressSummary, _$identity);

  /// Serializes this ProgressSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressSummary&&(identical(other.totalDiagnoses, totalDiagnoses) || other.totalDiagnoses == totalDiagnoses)&&(identical(other.currentLevel, currentLevel) || other.currentLevel == currentLevel)&&(identical(other.currentStage, currentStage) || other.currentStage == currentStage)&&(identical(other.overallChange, overallChange) || other.overallChange == overallChange)&&(identical(other.currentTrend, currentTrend) || other.currentTrend == currentTrend)&&(identical(other.streakDays, streakDays) || other.streakDays == streakDays)&&(identical(other.lastDiagnosedAt, lastDiagnosedAt) || other.lastDiagnosedAt == lastDiagnosedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalDiagnoses,currentLevel,currentStage,overallChange,currentTrend,streakDays,lastDiagnosedAt);

@override
String toString() {
  return 'ProgressSummary(totalDiagnoses: $totalDiagnoses, currentLevel: $currentLevel, currentStage: $currentStage, overallChange: $overallChange, currentTrend: $currentTrend, streakDays: $streakDays, lastDiagnosedAt: $lastDiagnosedAt)';
}


}

/// @nodoc
abstract mixin class $ProgressSummaryCopyWith<$Res>  {
  factory $ProgressSummaryCopyWith(ProgressSummary value, $Res Function(ProgressSummary) _then) = _$ProgressSummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readTotalDiagnoses) int totalDiagnoses,@JsonKey(readValue: _readCurrentLevel) num? currentLevel,@JsonKey(readValue: _readCurrentStage) String? currentStage,@JsonKey(readValue: _readOverallChange) num? overallChange,@JsonKey(readValue: _readCurrentTrend) String? currentTrend,@JsonKey(readValue: _readStreakDays) int streakDays,@JsonKey(readValue: _readLastDiagnosedAt) String? lastDiagnosedAt
});




}
/// @nodoc
class _$ProgressSummaryCopyWithImpl<$Res>
    implements $ProgressSummaryCopyWith<$Res> {
  _$ProgressSummaryCopyWithImpl(this._self, this._then);

  final ProgressSummary _self;
  final $Res Function(ProgressSummary) _then;

/// Create a copy of ProgressSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalDiagnoses = null,Object? currentLevel = freezed,Object? currentStage = freezed,Object? overallChange = freezed,Object? currentTrend = freezed,Object? streakDays = null,Object? lastDiagnosedAt = freezed,}) {
  return _then(_self.copyWith(
totalDiagnoses: null == totalDiagnoses ? _self.totalDiagnoses : totalDiagnoses // ignore: cast_nullable_to_non_nullable
as int,currentLevel: freezed == currentLevel ? _self.currentLevel : currentLevel // ignore: cast_nullable_to_non_nullable
as num?,currentStage: freezed == currentStage ? _self.currentStage : currentStage // ignore: cast_nullable_to_non_nullable
as String?,overallChange: freezed == overallChange ? _self.overallChange : overallChange // ignore: cast_nullable_to_non_nullable
as num?,currentTrend: freezed == currentTrend ? _self.currentTrend : currentTrend // ignore: cast_nullable_to_non_nullable
as String?,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as int,lastDiagnosedAt: freezed == lastDiagnosedAt ? _self.lastDiagnosedAt : lastDiagnosedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProgressSummary].
extension ProgressSummaryPatterns on ProgressSummary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProgressSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgressSummary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProgressSummary value)  $default,){
final _that = this;
switch (_that) {
case _ProgressSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProgressSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ProgressSummary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readTotalDiagnoses)  int totalDiagnoses, @JsonKey(readValue: _readCurrentLevel)  num? currentLevel, @JsonKey(readValue: _readCurrentStage)  String? currentStage, @JsonKey(readValue: _readOverallChange)  num? overallChange, @JsonKey(readValue: _readCurrentTrend)  String? currentTrend, @JsonKey(readValue: _readStreakDays)  int streakDays, @JsonKey(readValue: _readLastDiagnosedAt)  String? lastDiagnosedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgressSummary() when $default != null:
return $default(_that.totalDiagnoses,_that.currentLevel,_that.currentStage,_that.overallChange,_that.currentTrend,_that.streakDays,_that.lastDiagnosedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readTotalDiagnoses)  int totalDiagnoses, @JsonKey(readValue: _readCurrentLevel)  num? currentLevel, @JsonKey(readValue: _readCurrentStage)  String? currentStage, @JsonKey(readValue: _readOverallChange)  num? overallChange, @JsonKey(readValue: _readCurrentTrend)  String? currentTrend, @JsonKey(readValue: _readStreakDays)  int streakDays, @JsonKey(readValue: _readLastDiagnosedAt)  String? lastDiagnosedAt)  $default,) {final _that = this;
switch (_that) {
case _ProgressSummary():
return $default(_that.totalDiagnoses,_that.currentLevel,_that.currentStage,_that.overallChange,_that.currentTrend,_that.streakDays,_that.lastDiagnosedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readTotalDiagnoses)  int totalDiagnoses, @JsonKey(readValue: _readCurrentLevel)  num? currentLevel, @JsonKey(readValue: _readCurrentStage)  String? currentStage, @JsonKey(readValue: _readOverallChange)  num? overallChange, @JsonKey(readValue: _readCurrentTrend)  String? currentTrend, @JsonKey(readValue: _readStreakDays)  int streakDays, @JsonKey(readValue: _readLastDiagnosedAt)  String? lastDiagnosedAt)?  $default,) {final _that = this;
switch (_that) {
case _ProgressSummary() when $default != null:
return $default(_that.totalDiagnoses,_that.currentLevel,_that.currentStage,_that.overallChange,_that.currentTrend,_that.streakDays,_that.lastDiagnosedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProgressSummary extends ProgressSummary {
  const _ProgressSummary({@JsonKey(readValue: _readTotalDiagnoses) this.totalDiagnoses = 0, @JsonKey(readValue: _readCurrentLevel) this.currentLevel, @JsonKey(readValue: _readCurrentStage) this.currentStage, @JsonKey(readValue: _readOverallChange) this.overallChange, @JsonKey(readValue: _readCurrentTrend) this.currentTrend, @JsonKey(readValue: _readStreakDays) this.streakDays = 0, @JsonKey(readValue: _readLastDiagnosedAt) this.lastDiagnosedAt}): super._();
  factory _ProgressSummary.fromJson(Map<String, dynamic> json) => _$ProgressSummaryFromJson(json);

@override@JsonKey(readValue: _readTotalDiagnoses) final  int totalDiagnoses;
@override@JsonKey(readValue: _readCurrentLevel) final  num? currentLevel;
@override@JsonKey(readValue: _readCurrentStage) final  String? currentStage;
@override@JsonKey(readValue: _readOverallChange) final  num? overallChange;
@override@JsonKey(readValue: _readCurrentTrend) final  String? currentTrend;
@override@JsonKey(readValue: _readStreakDays) final  int streakDays;
@override@JsonKey(readValue: _readLastDiagnosedAt) final  String? lastDiagnosedAt;

/// Create a copy of ProgressSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressSummaryCopyWith<_ProgressSummary> get copyWith => __$ProgressSummaryCopyWithImpl<_ProgressSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgressSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressSummary&&(identical(other.totalDiagnoses, totalDiagnoses) || other.totalDiagnoses == totalDiagnoses)&&(identical(other.currentLevel, currentLevel) || other.currentLevel == currentLevel)&&(identical(other.currentStage, currentStage) || other.currentStage == currentStage)&&(identical(other.overallChange, overallChange) || other.overallChange == overallChange)&&(identical(other.currentTrend, currentTrend) || other.currentTrend == currentTrend)&&(identical(other.streakDays, streakDays) || other.streakDays == streakDays)&&(identical(other.lastDiagnosedAt, lastDiagnosedAt) || other.lastDiagnosedAt == lastDiagnosedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalDiagnoses,currentLevel,currentStage,overallChange,currentTrend,streakDays,lastDiagnosedAt);

@override
String toString() {
  return 'ProgressSummary(totalDiagnoses: $totalDiagnoses, currentLevel: $currentLevel, currentStage: $currentStage, overallChange: $overallChange, currentTrend: $currentTrend, streakDays: $streakDays, lastDiagnosedAt: $lastDiagnosedAt)';
}


}

/// @nodoc
abstract mixin class _$ProgressSummaryCopyWith<$Res> implements $ProgressSummaryCopyWith<$Res> {
  factory _$ProgressSummaryCopyWith(_ProgressSummary value, $Res Function(_ProgressSummary) _then) = __$ProgressSummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readTotalDiagnoses) int totalDiagnoses,@JsonKey(readValue: _readCurrentLevel) num? currentLevel,@JsonKey(readValue: _readCurrentStage) String? currentStage,@JsonKey(readValue: _readOverallChange) num? overallChange,@JsonKey(readValue: _readCurrentTrend) String? currentTrend,@JsonKey(readValue: _readStreakDays) int streakDays,@JsonKey(readValue: _readLastDiagnosedAt) String? lastDiagnosedAt
});




}
/// @nodoc
class __$ProgressSummaryCopyWithImpl<$Res>
    implements _$ProgressSummaryCopyWith<$Res> {
  __$ProgressSummaryCopyWithImpl(this._self, this._then);

  final _ProgressSummary _self;
  final $Res Function(_ProgressSummary) _then;

/// Create a copy of ProgressSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalDiagnoses = null,Object? currentLevel = freezed,Object? currentStage = freezed,Object? overallChange = freezed,Object? currentTrend = freezed,Object? streakDays = null,Object? lastDiagnosedAt = freezed,}) {
  return _then(_ProgressSummary(
totalDiagnoses: null == totalDiagnoses ? _self.totalDiagnoses : totalDiagnoses // ignore: cast_nullable_to_non_nullable
as int,currentLevel: freezed == currentLevel ? _self.currentLevel : currentLevel // ignore: cast_nullable_to_non_nullable
as num?,currentStage: freezed == currentStage ? _self.currentStage : currentStage // ignore: cast_nullable_to_non_nullable
as String?,overallChange: freezed == overallChange ? _self.overallChange : overallChange // ignore: cast_nullable_to_non_nullable
as num?,currentTrend: freezed == currentTrend ? _self.currentTrend : currentTrend // ignore: cast_nullable_to_non_nullable
as String?,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as int,lastDiagnosedAt: freezed == lastDiagnosedAt ? _self.lastDiagnosedAt : lastDiagnosedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
