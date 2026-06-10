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

@JsonKey(readValue: _readOverall) num? get overallScore;@JsonKey(readValue: _readSessions) int? get totalSessions;@JsonKey(readValue: _readStreak) int? get streak;@JsonKey(readValue: _readFocus) num? get focusTimeMinutes;@JsonKey(readValue: _readUpdated) String? get updatedAt;
/// Create a copy of ProgressSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressSummaryCopyWith<ProgressSummary> get copyWith => _$ProgressSummaryCopyWithImpl<ProgressSummary>(this as ProgressSummary, _$identity);

  /// Serializes this ProgressSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressSummary&&(identical(other.overallScore, overallScore) || other.overallScore == overallScore)&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.focusTimeMinutes, focusTimeMinutes) || other.focusTimeMinutes == focusTimeMinutes)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,overallScore,totalSessions,streak,focusTimeMinutes,updatedAt);

@override
String toString() {
  return 'ProgressSummary(overallScore: $overallScore, totalSessions: $totalSessions, streak: $streak, focusTimeMinutes: $focusTimeMinutes, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ProgressSummaryCopyWith<$Res>  {
  factory $ProgressSummaryCopyWith(ProgressSummary value, $Res Function(ProgressSummary) _then) = _$ProgressSummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readOverall) num? overallScore,@JsonKey(readValue: _readSessions) int? totalSessions,@JsonKey(readValue: _readStreak) int? streak,@JsonKey(readValue: _readFocus) num? focusTimeMinutes,@JsonKey(readValue: _readUpdated) String? updatedAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? overallScore = freezed,Object? totalSessions = freezed,Object? streak = freezed,Object? focusTimeMinutes = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
overallScore: freezed == overallScore ? _self.overallScore : overallScore // ignore: cast_nullable_to_non_nullable
as num?,totalSessions: freezed == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int?,streak: freezed == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int?,focusTimeMinutes: freezed == focusTimeMinutes ? _self.focusTimeMinutes : focusTimeMinutes // ignore: cast_nullable_to_non_nullable
as num?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readOverall)  num? overallScore, @JsonKey(readValue: _readSessions)  int? totalSessions, @JsonKey(readValue: _readStreak)  int? streak, @JsonKey(readValue: _readFocus)  num? focusTimeMinutes, @JsonKey(readValue: _readUpdated)  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgressSummary() when $default != null:
return $default(_that.overallScore,_that.totalSessions,_that.streak,_that.focusTimeMinutes,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readOverall)  num? overallScore, @JsonKey(readValue: _readSessions)  int? totalSessions, @JsonKey(readValue: _readStreak)  int? streak, @JsonKey(readValue: _readFocus)  num? focusTimeMinutes, @JsonKey(readValue: _readUpdated)  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ProgressSummary():
return $default(_that.overallScore,_that.totalSessions,_that.streak,_that.focusTimeMinutes,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readOverall)  num? overallScore, @JsonKey(readValue: _readSessions)  int? totalSessions, @JsonKey(readValue: _readStreak)  int? streak, @JsonKey(readValue: _readFocus)  num? focusTimeMinutes, @JsonKey(readValue: _readUpdated)  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ProgressSummary() when $default != null:
return $default(_that.overallScore,_that.totalSessions,_that.streak,_that.focusTimeMinutes,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProgressSummary implements ProgressSummary {
  const _ProgressSummary({@JsonKey(readValue: _readOverall) this.overallScore, @JsonKey(readValue: _readSessions) this.totalSessions, @JsonKey(readValue: _readStreak) this.streak, @JsonKey(readValue: _readFocus) this.focusTimeMinutes, @JsonKey(readValue: _readUpdated) this.updatedAt});
  factory _ProgressSummary.fromJson(Map<String, dynamic> json) => _$ProgressSummaryFromJson(json);

@override@JsonKey(readValue: _readOverall) final  num? overallScore;
@override@JsonKey(readValue: _readSessions) final  int? totalSessions;
@override@JsonKey(readValue: _readStreak) final  int? streak;
@override@JsonKey(readValue: _readFocus) final  num? focusTimeMinutes;
@override@JsonKey(readValue: _readUpdated) final  String? updatedAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressSummary&&(identical(other.overallScore, overallScore) || other.overallScore == overallScore)&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.focusTimeMinutes, focusTimeMinutes) || other.focusTimeMinutes == focusTimeMinutes)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,overallScore,totalSessions,streak,focusTimeMinutes,updatedAt);

@override
String toString() {
  return 'ProgressSummary(overallScore: $overallScore, totalSessions: $totalSessions, streak: $streak, focusTimeMinutes: $focusTimeMinutes, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ProgressSummaryCopyWith<$Res> implements $ProgressSummaryCopyWith<$Res> {
  factory _$ProgressSummaryCopyWith(_ProgressSummary value, $Res Function(_ProgressSummary) _then) = __$ProgressSummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readOverall) num? overallScore,@JsonKey(readValue: _readSessions) int? totalSessions,@JsonKey(readValue: _readStreak) int? streak,@JsonKey(readValue: _readFocus) num? focusTimeMinutes,@JsonKey(readValue: _readUpdated) String? updatedAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? overallScore = freezed,Object? totalSessions = freezed,Object? streak = freezed,Object? focusTimeMinutes = freezed,Object? updatedAt = freezed,}) {
  return _then(_ProgressSummary(
overallScore: freezed == overallScore ? _self.overallScore : overallScore // ignore: cast_nullable_to_non_nullable
as num?,totalSessions: freezed == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int?,streak: freezed == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int?,focusTimeMinutes: freezed == focusTimeMinutes ? _self.focusTimeMinutes : focusTimeMinutes // ignore: cast_nullable_to_non_nullable
as num?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
