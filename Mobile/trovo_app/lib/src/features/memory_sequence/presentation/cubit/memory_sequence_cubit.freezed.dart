// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memory_sequence_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemorySequenceState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemorySequenceState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemorySequenceState()';
}


}

/// @nodoc
class $MemorySequenceStateCopyWith<$Res>  {
$MemorySequenceStateCopyWith(MemorySequenceState _, $Res Function(MemorySequenceState) __);
}


/// Adds pattern-matching-related methods to [MemorySequenceState].
extension MemorySequenceStatePatterns on MemorySequenceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _MemorySequenceInitial value)?  initial,TResult Function( _MemorySequenceInProgress value)?  inProgress,TResult Function( _MemorySequenceCompleted value)?  completed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemorySequenceInitial() when initial != null:
return initial(_that);case _MemorySequenceInProgress() when inProgress != null:
return inProgress(_that);case _MemorySequenceCompleted() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _MemorySequenceInitial value)  initial,required TResult Function( _MemorySequenceInProgress value)  inProgress,required TResult Function( _MemorySequenceCompleted value)  completed,}){
final _that = this;
switch (_that) {
case _MemorySequenceInitial():
return initial(_that);case _MemorySequenceInProgress():
return inProgress(_that);case _MemorySequenceCompleted():
return completed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _MemorySequenceInitial value)?  initial,TResult? Function( _MemorySequenceInProgress value)?  inProgress,TResult? Function( _MemorySequenceCompleted value)?  completed,}){
final _that = this;
switch (_that) {
case _MemorySequenceInitial() when initial != null:
return initial(_that);case _MemorySequenceInProgress() when inProgress != null:
return inProgress(_that);case _MemorySequenceCompleted() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( int level,  int roundIndex,  int totalRounds,  MemorySymbol currentSymbol,  bool canAnswer,  int score,  int correctCount,  int streak,  int maxStreak,  int fastThresholdMs,  List<MemoryRound> rounds)?  inProgress,TResult Function( int level,  int score,  int correctCount,  int totalRounds,  double accuracy,  int avgReactionTimeMs,  int maxStreak,  List<MemoryRound> rounds)?  completed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemorySequenceInitial() when initial != null:
return initial();case _MemorySequenceInProgress() when inProgress != null:
return inProgress(_that.level,_that.roundIndex,_that.totalRounds,_that.currentSymbol,_that.canAnswer,_that.score,_that.correctCount,_that.streak,_that.maxStreak,_that.fastThresholdMs,_that.rounds);case _MemorySequenceCompleted() when completed != null:
return completed(_that.level,_that.score,_that.correctCount,_that.totalRounds,_that.accuracy,_that.avgReactionTimeMs,_that.maxStreak,_that.rounds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( int level,  int roundIndex,  int totalRounds,  MemorySymbol currentSymbol,  bool canAnswer,  int score,  int correctCount,  int streak,  int maxStreak,  int fastThresholdMs,  List<MemoryRound> rounds)  inProgress,required TResult Function( int level,  int score,  int correctCount,  int totalRounds,  double accuracy,  int avgReactionTimeMs,  int maxStreak,  List<MemoryRound> rounds)  completed,}) {final _that = this;
switch (_that) {
case _MemorySequenceInitial():
return initial();case _MemorySequenceInProgress():
return inProgress(_that.level,_that.roundIndex,_that.totalRounds,_that.currentSymbol,_that.canAnswer,_that.score,_that.correctCount,_that.streak,_that.maxStreak,_that.fastThresholdMs,_that.rounds);case _MemorySequenceCompleted():
return completed(_that.level,_that.score,_that.correctCount,_that.totalRounds,_that.accuracy,_that.avgReactionTimeMs,_that.maxStreak,_that.rounds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( int level,  int roundIndex,  int totalRounds,  MemorySymbol currentSymbol,  bool canAnswer,  int score,  int correctCount,  int streak,  int maxStreak,  int fastThresholdMs,  List<MemoryRound> rounds)?  inProgress,TResult? Function( int level,  int score,  int correctCount,  int totalRounds,  double accuracy,  int avgReactionTimeMs,  int maxStreak,  List<MemoryRound> rounds)?  completed,}) {final _that = this;
switch (_that) {
case _MemorySequenceInitial() when initial != null:
return initial();case _MemorySequenceInProgress() when inProgress != null:
return inProgress(_that.level,_that.roundIndex,_that.totalRounds,_that.currentSymbol,_that.canAnswer,_that.score,_that.correctCount,_that.streak,_that.maxStreak,_that.fastThresholdMs,_that.rounds);case _MemorySequenceCompleted() when completed != null:
return completed(_that.level,_that.score,_that.correctCount,_that.totalRounds,_that.accuracy,_that.avgReactionTimeMs,_that.maxStreak,_that.rounds);case _:
  return null;

}
}

}

/// @nodoc


class _MemorySequenceInitial implements MemorySequenceState {
  const _MemorySequenceInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemorySequenceInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemorySequenceState.initial()';
}


}




/// @nodoc


class _MemorySequenceInProgress implements MemorySequenceState {
  const _MemorySequenceInProgress({required this.level, required this.roundIndex, required this.totalRounds, required this.currentSymbol, required this.canAnswer, required this.score, required this.correctCount, required this.streak, required this.maxStreak, required this.fastThresholdMs, required final  List<MemoryRound> rounds}): _rounds = rounds;
  

 final  int level;
 final  int roundIndex;
 final  int totalRounds;
 final  MemorySymbol currentSymbol;
 final  bool canAnswer;
 final  int score;
 final  int correctCount;
 final  int streak;
 final  int maxStreak;
 final  int fastThresholdMs;
 final  List<MemoryRound> _rounds;
 List<MemoryRound> get rounds {
  if (_rounds is EqualUnmodifiableListView) return _rounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rounds);
}


/// Create a copy of MemorySequenceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemorySequenceInProgressCopyWith<_MemorySequenceInProgress> get copyWith => __$MemorySequenceInProgressCopyWithImpl<_MemorySequenceInProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemorySequenceInProgress&&(identical(other.level, level) || other.level == level)&&(identical(other.roundIndex, roundIndex) || other.roundIndex == roundIndex)&&(identical(other.totalRounds, totalRounds) || other.totalRounds == totalRounds)&&(identical(other.currentSymbol, currentSymbol) || other.currentSymbol == currentSymbol)&&(identical(other.canAnswer, canAnswer) || other.canAnswer == canAnswer)&&(identical(other.score, score) || other.score == score)&&(identical(other.correctCount, correctCount) || other.correctCount == correctCount)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.maxStreak, maxStreak) || other.maxStreak == maxStreak)&&(identical(other.fastThresholdMs, fastThresholdMs) || other.fastThresholdMs == fastThresholdMs)&&const DeepCollectionEquality().equals(other._rounds, _rounds));
}


@override
int get hashCode => Object.hash(runtimeType,level,roundIndex,totalRounds,currentSymbol,canAnswer,score,correctCount,streak,maxStreak,fastThresholdMs,const DeepCollectionEquality().hash(_rounds));

@override
String toString() {
  return 'MemorySequenceState.inProgress(level: $level, roundIndex: $roundIndex, totalRounds: $totalRounds, currentSymbol: $currentSymbol, canAnswer: $canAnswer, score: $score, correctCount: $correctCount, streak: $streak, maxStreak: $maxStreak, fastThresholdMs: $fastThresholdMs, rounds: $rounds)';
}


}

/// @nodoc
abstract mixin class _$MemorySequenceInProgressCopyWith<$Res> implements $MemorySequenceStateCopyWith<$Res> {
  factory _$MemorySequenceInProgressCopyWith(_MemorySequenceInProgress value, $Res Function(_MemorySequenceInProgress) _then) = __$MemorySequenceInProgressCopyWithImpl;
@useResult
$Res call({
 int level, int roundIndex, int totalRounds, MemorySymbol currentSymbol, bool canAnswer, int score, int correctCount, int streak, int maxStreak, int fastThresholdMs, List<MemoryRound> rounds
});




}
/// @nodoc
class __$MemorySequenceInProgressCopyWithImpl<$Res>
    implements _$MemorySequenceInProgressCopyWith<$Res> {
  __$MemorySequenceInProgressCopyWithImpl(this._self, this._then);

  final _MemorySequenceInProgress _self;
  final $Res Function(_MemorySequenceInProgress) _then;

/// Create a copy of MemorySequenceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? level = null,Object? roundIndex = null,Object? totalRounds = null,Object? currentSymbol = null,Object? canAnswer = null,Object? score = null,Object? correctCount = null,Object? streak = null,Object? maxStreak = null,Object? fastThresholdMs = null,Object? rounds = null,}) {
  return _then(_MemorySequenceInProgress(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,roundIndex: null == roundIndex ? _self.roundIndex : roundIndex // ignore: cast_nullable_to_non_nullable
as int,totalRounds: null == totalRounds ? _self.totalRounds : totalRounds // ignore: cast_nullable_to_non_nullable
as int,currentSymbol: null == currentSymbol ? _self.currentSymbol : currentSymbol // ignore: cast_nullable_to_non_nullable
as MemorySymbol,canAnswer: null == canAnswer ? _self.canAnswer : canAnswer // ignore: cast_nullable_to_non_nullable
as bool,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,correctCount: null == correctCount ? _self.correctCount : correctCount // ignore: cast_nullable_to_non_nullable
as int,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,maxStreak: null == maxStreak ? _self.maxStreak : maxStreak // ignore: cast_nullable_to_non_nullable
as int,fastThresholdMs: null == fastThresholdMs ? _self.fastThresholdMs : fastThresholdMs // ignore: cast_nullable_to_non_nullable
as int,rounds: null == rounds ? _self._rounds : rounds // ignore: cast_nullable_to_non_nullable
as List<MemoryRound>,
  ));
}


}

/// @nodoc


class _MemorySequenceCompleted implements MemorySequenceState {
  const _MemorySequenceCompleted({required this.level, required this.score, required this.correctCount, required this.totalRounds, required this.accuracy, required this.avgReactionTimeMs, required this.maxStreak, required final  List<MemoryRound> rounds}): _rounds = rounds;
  

 final  int level;
 final  int score;
 final  int correctCount;
 final  int totalRounds;
 final  double accuracy;
 final  int avgReactionTimeMs;
 final  int maxStreak;
 final  List<MemoryRound> _rounds;
 List<MemoryRound> get rounds {
  if (_rounds is EqualUnmodifiableListView) return _rounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rounds);
}


/// Create a copy of MemorySequenceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemorySequenceCompletedCopyWith<_MemorySequenceCompleted> get copyWith => __$MemorySequenceCompletedCopyWithImpl<_MemorySequenceCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemorySequenceCompleted&&(identical(other.level, level) || other.level == level)&&(identical(other.score, score) || other.score == score)&&(identical(other.correctCount, correctCount) || other.correctCount == correctCount)&&(identical(other.totalRounds, totalRounds) || other.totalRounds == totalRounds)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.avgReactionTimeMs, avgReactionTimeMs) || other.avgReactionTimeMs == avgReactionTimeMs)&&(identical(other.maxStreak, maxStreak) || other.maxStreak == maxStreak)&&const DeepCollectionEquality().equals(other._rounds, _rounds));
}


@override
int get hashCode => Object.hash(runtimeType,level,score,correctCount,totalRounds,accuracy,avgReactionTimeMs,maxStreak,const DeepCollectionEquality().hash(_rounds));

@override
String toString() {
  return 'MemorySequenceState.completed(level: $level, score: $score, correctCount: $correctCount, totalRounds: $totalRounds, accuracy: $accuracy, avgReactionTimeMs: $avgReactionTimeMs, maxStreak: $maxStreak, rounds: $rounds)';
}


}

/// @nodoc
abstract mixin class _$MemorySequenceCompletedCopyWith<$Res> implements $MemorySequenceStateCopyWith<$Res> {
  factory _$MemorySequenceCompletedCopyWith(_MemorySequenceCompleted value, $Res Function(_MemorySequenceCompleted) _then) = __$MemorySequenceCompletedCopyWithImpl;
@useResult
$Res call({
 int level, int score, int correctCount, int totalRounds, double accuracy, int avgReactionTimeMs, int maxStreak, List<MemoryRound> rounds
});




}
/// @nodoc
class __$MemorySequenceCompletedCopyWithImpl<$Res>
    implements _$MemorySequenceCompletedCopyWith<$Res> {
  __$MemorySequenceCompletedCopyWithImpl(this._self, this._then);

  final _MemorySequenceCompleted _self;
  final $Res Function(_MemorySequenceCompleted) _then;

/// Create a copy of MemorySequenceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? level = null,Object? score = null,Object? correctCount = null,Object? totalRounds = null,Object? accuracy = null,Object? avgReactionTimeMs = null,Object? maxStreak = null,Object? rounds = null,}) {
  return _then(_MemorySequenceCompleted(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,correctCount: null == correctCount ? _self.correctCount : correctCount // ignore: cast_nullable_to_non_nullable
as int,totalRounds: null == totalRounds ? _self.totalRounds : totalRounds // ignore: cast_nullable_to_non_nullable
as int,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,avgReactionTimeMs: null == avgReactionTimeMs ? _self.avgReactionTimeMs : avgReactionTimeMs // ignore: cast_nullable_to_non_nullable
as int,maxStreak: null == maxStreak ? _self.maxStreak : maxStreak // ignore: cast_nullable_to_non_nullable
as int,rounds: null == rounds ? _self._rounds : rounds // ignore: cast_nullable_to_non_nullable
as List<MemoryRound>,
  ));
}


}

// dart format on
