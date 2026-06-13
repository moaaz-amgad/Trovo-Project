// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mini_game_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MiniGameStats {

@JsonKey(readValue: _readTotal) int? get totalSessions;@JsonKey(readValue: _readAvgScore) num? get averageScore;@JsonKey(readValue: _readAvgAccuracy) num? get averageAccuracy;@JsonKey(readValue: _readAvgReaction) num? get averageReactionTimeMs;@JsonKey(readValue: _readBestScore) num? get bestScore;@JsonKey(readValue: _readFocusScore) num? get focusScore;
/// Create a copy of MiniGameStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MiniGameStatsCopyWith<MiniGameStats> get copyWith => _$MiniGameStatsCopyWithImpl<MiniGameStats>(this as MiniGameStats, _$identity);

  /// Serializes this MiniGameStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MiniGameStats&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore)&&(identical(other.averageAccuracy, averageAccuracy) || other.averageAccuracy == averageAccuracy)&&(identical(other.averageReactionTimeMs, averageReactionTimeMs) || other.averageReactionTimeMs == averageReactionTimeMs)&&(identical(other.bestScore, bestScore) || other.bestScore == bestScore)&&(identical(other.focusScore, focusScore) || other.focusScore == focusScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalSessions,averageScore,averageAccuracy,averageReactionTimeMs,bestScore,focusScore);

@override
String toString() {
  return 'MiniGameStats(totalSessions: $totalSessions, averageScore: $averageScore, averageAccuracy: $averageAccuracy, averageReactionTimeMs: $averageReactionTimeMs, bestScore: $bestScore, focusScore: $focusScore)';
}


}

/// @nodoc
abstract mixin class $MiniGameStatsCopyWith<$Res>  {
  factory $MiniGameStatsCopyWith(MiniGameStats value, $Res Function(MiniGameStats) _then) = _$MiniGameStatsCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readTotal) int? totalSessions,@JsonKey(readValue: _readAvgScore) num? averageScore,@JsonKey(readValue: _readAvgAccuracy) num? averageAccuracy,@JsonKey(readValue: _readAvgReaction) num? averageReactionTimeMs,@JsonKey(readValue: _readBestScore) num? bestScore,@JsonKey(readValue: _readFocusScore) num? focusScore
});




}
/// @nodoc
class _$MiniGameStatsCopyWithImpl<$Res>
    implements $MiniGameStatsCopyWith<$Res> {
  _$MiniGameStatsCopyWithImpl(this._self, this._then);

  final MiniGameStats _self;
  final $Res Function(MiniGameStats) _then;

/// Create a copy of MiniGameStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalSessions = freezed,Object? averageScore = freezed,Object? averageAccuracy = freezed,Object? averageReactionTimeMs = freezed,Object? bestScore = freezed,Object? focusScore = freezed,}) {
  return _then(_self.copyWith(
totalSessions: freezed == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int?,averageScore: freezed == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as num?,averageAccuracy: freezed == averageAccuracy ? _self.averageAccuracy : averageAccuracy // ignore: cast_nullable_to_non_nullable
as num?,averageReactionTimeMs: freezed == averageReactionTimeMs ? _self.averageReactionTimeMs : averageReactionTimeMs // ignore: cast_nullable_to_non_nullable
as num?,bestScore: freezed == bestScore ? _self.bestScore : bestScore // ignore: cast_nullable_to_non_nullable
as num?,focusScore: freezed == focusScore ? _self.focusScore : focusScore // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [MiniGameStats].
extension MiniGameStatsPatterns on MiniGameStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MiniGameStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MiniGameStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MiniGameStats value)  $default,){
final _that = this;
switch (_that) {
case _MiniGameStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MiniGameStats value)?  $default,){
final _that = this;
switch (_that) {
case _MiniGameStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readTotal)  int? totalSessions, @JsonKey(readValue: _readAvgScore)  num? averageScore, @JsonKey(readValue: _readAvgAccuracy)  num? averageAccuracy, @JsonKey(readValue: _readAvgReaction)  num? averageReactionTimeMs, @JsonKey(readValue: _readBestScore)  num? bestScore, @JsonKey(readValue: _readFocusScore)  num? focusScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MiniGameStats() when $default != null:
return $default(_that.totalSessions,_that.averageScore,_that.averageAccuracy,_that.averageReactionTimeMs,_that.bestScore,_that.focusScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readTotal)  int? totalSessions, @JsonKey(readValue: _readAvgScore)  num? averageScore, @JsonKey(readValue: _readAvgAccuracy)  num? averageAccuracy, @JsonKey(readValue: _readAvgReaction)  num? averageReactionTimeMs, @JsonKey(readValue: _readBestScore)  num? bestScore, @JsonKey(readValue: _readFocusScore)  num? focusScore)  $default,) {final _that = this;
switch (_that) {
case _MiniGameStats():
return $default(_that.totalSessions,_that.averageScore,_that.averageAccuracy,_that.averageReactionTimeMs,_that.bestScore,_that.focusScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readTotal)  int? totalSessions, @JsonKey(readValue: _readAvgScore)  num? averageScore, @JsonKey(readValue: _readAvgAccuracy)  num? averageAccuracy, @JsonKey(readValue: _readAvgReaction)  num? averageReactionTimeMs, @JsonKey(readValue: _readBestScore)  num? bestScore, @JsonKey(readValue: _readFocusScore)  num? focusScore)?  $default,) {final _that = this;
switch (_that) {
case _MiniGameStats() when $default != null:
return $default(_that.totalSessions,_that.averageScore,_that.averageAccuracy,_that.averageReactionTimeMs,_that.bestScore,_that.focusScore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MiniGameStats implements MiniGameStats {
  const _MiniGameStats({@JsonKey(readValue: _readTotal) this.totalSessions, @JsonKey(readValue: _readAvgScore) this.averageScore, @JsonKey(readValue: _readAvgAccuracy) this.averageAccuracy, @JsonKey(readValue: _readAvgReaction) this.averageReactionTimeMs, @JsonKey(readValue: _readBestScore) this.bestScore, @JsonKey(readValue: _readFocusScore) this.focusScore});
  factory _MiniGameStats.fromJson(Map<String, dynamic> json) => _$MiniGameStatsFromJson(json);

@override@JsonKey(readValue: _readTotal) final  int? totalSessions;
@override@JsonKey(readValue: _readAvgScore) final  num? averageScore;
@override@JsonKey(readValue: _readAvgAccuracy) final  num? averageAccuracy;
@override@JsonKey(readValue: _readAvgReaction) final  num? averageReactionTimeMs;
@override@JsonKey(readValue: _readBestScore) final  num? bestScore;
@override@JsonKey(readValue: _readFocusScore) final  num? focusScore;

/// Create a copy of MiniGameStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MiniGameStatsCopyWith<_MiniGameStats> get copyWith => __$MiniGameStatsCopyWithImpl<_MiniGameStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MiniGameStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MiniGameStats&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore)&&(identical(other.averageAccuracy, averageAccuracy) || other.averageAccuracy == averageAccuracy)&&(identical(other.averageReactionTimeMs, averageReactionTimeMs) || other.averageReactionTimeMs == averageReactionTimeMs)&&(identical(other.bestScore, bestScore) || other.bestScore == bestScore)&&(identical(other.focusScore, focusScore) || other.focusScore == focusScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalSessions,averageScore,averageAccuracy,averageReactionTimeMs,bestScore,focusScore);

@override
String toString() {
  return 'MiniGameStats(totalSessions: $totalSessions, averageScore: $averageScore, averageAccuracy: $averageAccuracy, averageReactionTimeMs: $averageReactionTimeMs, bestScore: $bestScore, focusScore: $focusScore)';
}


}

/// @nodoc
abstract mixin class _$MiniGameStatsCopyWith<$Res> implements $MiniGameStatsCopyWith<$Res> {
  factory _$MiniGameStatsCopyWith(_MiniGameStats value, $Res Function(_MiniGameStats) _then) = __$MiniGameStatsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readTotal) int? totalSessions,@JsonKey(readValue: _readAvgScore) num? averageScore,@JsonKey(readValue: _readAvgAccuracy) num? averageAccuracy,@JsonKey(readValue: _readAvgReaction) num? averageReactionTimeMs,@JsonKey(readValue: _readBestScore) num? bestScore,@JsonKey(readValue: _readFocusScore) num? focusScore
});




}
/// @nodoc
class __$MiniGameStatsCopyWithImpl<$Res>
    implements _$MiniGameStatsCopyWith<$Res> {
  __$MiniGameStatsCopyWithImpl(this._self, this._then);

  final _MiniGameStats _self;
  final $Res Function(_MiniGameStats) _then;

/// Create a copy of MiniGameStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalSessions = freezed,Object? averageScore = freezed,Object? averageAccuracy = freezed,Object? averageReactionTimeMs = freezed,Object? bestScore = freezed,Object? focusScore = freezed,}) {
  return _then(_MiniGameStats(
totalSessions: freezed == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int?,averageScore: freezed == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as num?,averageAccuracy: freezed == averageAccuracy ? _self.averageAccuracy : averageAccuracy // ignore: cast_nullable_to_non_nullable
as num?,averageReactionTimeMs: freezed == averageReactionTimeMs ? _self.averageReactionTimeMs : averageReactionTimeMs // ignore: cast_nullable_to_non_nullable
as num?,bestScore: freezed == bestScore ? _self.bestScore : bestScore // ignore: cast_nullable_to_non_nullable
as num?,focusScore: freezed == focusScore ? _self.focusScore : focusScore // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on
