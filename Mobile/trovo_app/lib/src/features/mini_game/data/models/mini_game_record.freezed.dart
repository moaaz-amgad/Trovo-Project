// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mini_game_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MiniGameRecord {

 int? get id;@JsonKey(readValue: _readGameType) String? get gameType; num? get score;@JsonKey(readValue: _readReaction) num? get reactionTimeMs;@JsonKey(readValue: _readAccuracy) num? get accuracyPercentage;@JsonKey(readValue: _readDifficulty) String? get difficultyLevel;@JsonKey(readValue: _readDuration) num? get durationSeconds;@JsonKey(readValue: _readCreatedAt) String? get createdAt;
/// Create a copy of MiniGameRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MiniGameRecordCopyWith<MiniGameRecord> get copyWith => _$MiniGameRecordCopyWithImpl<MiniGameRecord>(this as MiniGameRecord, _$identity);

  /// Serializes this MiniGameRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MiniGameRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.gameType, gameType) || other.gameType == gameType)&&(identical(other.score, score) || other.score == score)&&(identical(other.reactionTimeMs, reactionTimeMs) || other.reactionTimeMs == reactionTimeMs)&&(identical(other.accuracyPercentage, accuracyPercentage) || other.accuracyPercentage == accuracyPercentage)&&(identical(other.difficultyLevel, difficultyLevel) || other.difficultyLevel == difficultyLevel)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,gameType,score,reactionTimeMs,accuracyPercentage,difficultyLevel,durationSeconds,createdAt);

@override
String toString() {
  return 'MiniGameRecord(id: $id, gameType: $gameType, score: $score, reactionTimeMs: $reactionTimeMs, accuracyPercentage: $accuracyPercentage, difficultyLevel: $difficultyLevel, durationSeconds: $durationSeconds, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MiniGameRecordCopyWith<$Res>  {
  factory $MiniGameRecordCopyWith(MiniGameRecord value, $Res Function(MiniGameRecord) _then) = _$MiniGameRecordCopyWithImpl;
@useResult
$Res call({
 int? id,@JsonKey(readValue: _readGameType) String? gameType, num? score,@JsonKey(readValue: _readReaction) num? reactionTimeMs,@JsonKey(readValue: _readAccuracy) num? accuracyPercentage,@JsonKey(readValue: _readDifficulty) String? difficultyLevel,@JsonKey(readValue: _readDuration) num? durationSeconds,@JsonKey(readValue: _readCreatedAt) String? createdAt
});




}
/// @nodoc
class _$MiniGameRecordCopyWithImpl<$Res>
    implements $MiniGameRecordCopyWith<$Res> {
  _$MiniGameRecordCopyWithImpl(this._self, this._then);

  final MiniGameRecord _self;
  final $Res Function(MiniGameRecord) _then;

/// Create a copy of MiniGameRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? gameType = freezed,Object? score = freezed,Object? reactionTimeMs = freezed,Object? accuracyPercentage = freezed,Object? difficultyLevel = freezed,Object? durationSeconds = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,gameType: freezed == gameType ? _self.gameType : gameType // ignore: cast_nullable_to_non_nullable
as String?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as num?,reactionTimeMs: freezed == reactionTimeMs ? _self.reactionTimeMs : reactionTimeMs // ignore: cast_nullable_to_non_nullable
as num?,accuracyPercentage: freezed == accuracyPercentage ? _self.accuracyPercentage : accuracyPercentage // ignore: cast_nullable_to_non_nullable
as num?,difficultyLevel: freezed == difficultyLevel ? _self.difficultyLevel : difficultyLevel // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as num?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MiniGameRecord].
extension MiniGameRecordPatterns on MiniGameRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MiniGameRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MiniGameRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MiniGameRecord value)  $default,){
final _that = this;
switch (_that) {
case _MiniGameRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MiniGameRecord value)?  $default,){
final _that = this;
switch (_that) {
case _MiniGameRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id, @JsonKey(readValue: _readGameType)  String? gameType,  num? score, @JsonKey(readValue: _readReaction)  num? reactionTimeMs, @JsonKey(readValue: _readAccuracy)  num? accuracyPercentage, @JsonKey(readValue: _readDifficulty)  String? difficultyLevel, @JsonKey(readValue: _readDuration)  num? durationSeconds, @JsonKey(readValue: _readCreatedAt)  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MiniGameRecord() when $default != null:
return $default(_that.id,_that.gameType,_that.score,_that.reactionTimeMs,_that.accuracyPercentage,_that.difficultyLevel,_that.durationSeconds,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id, @JsonKey(readValue: _readGameType)  String? gameType,  num? score, @JsonKey(readValue: _readReaction)  num? reactionTimeMs, @JsonKey(readValue: _readAccuracy)  num? accuracyPercentage, @JsonKey(readValue: _readDifficulty)  String? difficultyLevel, @JsonKey(readValue: _readDuration)  num? durationSeconds, @JsonKey(readValue: _readCreatedAt)  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _MiniGameRecord():
return $default(_that.id,_that.gameType,_that.score,_that.reactionTimeMs,_that.accuracyPercentage,_that.difficultyLevel,_that.durationSeconds,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id, @JsonKey(readValue: _readGameType)  String? gameType,  num? score, @JsonKey(readValue: _readReaction)  num? reactionTimeMs, @JsonKey(readValue: _readAccuracy)  num? accuracyPercentage, @JsonKey(readValue: _readDifficulty)  String? difficultyLevel, @JsonKey(readValue: _readDuration)  num? durationSeconds, @JsonKey(readValue: _readCreatedAt)  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MiniGameRecord() when $default != null:
return $default(_that.id,_that.gameType,_that.score,_that.reactionTimeMs,_that.accuracyPercentage,_that.difficultyLevel,_that.durationSeconds,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MiniGameRecord implements MiniGameRecord {
  const _MiniGameRecord({this.id, @JsonKey(readValue: _readGameType) this.gameType, this.score, @JsonKey(readValue: _readReaction) this.reactionTimeMs, @JsonKey(readValue: _readAccuracy) this.accuracyPercentage, @JsonKey(readValue: _readDifficulty) this.difficultyLevel, @JsonKey(readValue: _readDuration) this.durationSeconds, @JsonKey(readValue: _readCreatedAt) this.createdAt});
  factory _MiniGameRecord.fromJson(Map<String, dynamic> json) => _$MiniGameRecordFromJson(json);

@override final  int? id;
@override@JsonKey(readValue: _readGameType) final  String? gameType;
@override final  num? score;
@override@JsonKey(readValue: _readReaction) final  num? reactionTimeMs;
@override@JsonKey(readValue: _readAccuracy) final  num? accuracyPercentage;
@override@JsonKey(readValue: _readDifficulty) final  String? difficultyLevel;
@override@JsonKey(readValue: _readDuration) final  num? durationSeconds;
@override@JsonKey(readValue: _readCreatedAt) final  String? createdAt;

/// Create a copy of MiniGameRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MiniGameRecordCopyWith<_MiniGameRecord> get copyWith => __$MiniGameRecordCopyWithImpl<_MiniGameRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MiniGameRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MiniGameRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.gameType, gameType) || other.gameType == gameType)&&(identical(other.score, score) || other.score == score)&&(identical(other.reactionTimeMs, reactionTimeMs) || other.reactionTimeMs == reactionTimeMs)&&(identical(other.accuracyPercentage, accuracyPercentage) || other.accuracyPercentage == accuracyPercentage)&&(identical(other.difficultyLevel, difficultyLevel) || other.difficultyLevel == difficultyLevel)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,gameType,score,reactionTimeMs,accuracyPercentage,difficultyLevel,durationSeconds,createdAt);

@override
String toString() {
  return 'MiniGameRecord(id: $id, gameType: $gameType, score: $score, reactionTimeMs: $reactionTimeMs, accuracyPercentage: $accuracyPercentage, difficultyLevel: $difficultyLevel, durationSeconds: $durationSeconds, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MiniGameRecordCopyWith<$Res> implements $MiniGameRecordCopyWith<$Res> {
  factory _$MiniGameRecordCopyWith(_MiniGameRecord value, $Res Function(_MiniGameRecord) _then) = __$MiniGameRecordCopyWithImpl;
@override @useResult
$Res call({
 int? id,@JsonKey(readValue: _readGameType) String? gameType, num? score,@JsonKey(readValue: _readReaction) num? reactionTimeMs,@JsonKey(readValue: _readAccuracy) num? accuracyPercentage,@JsonKey(readValue: _readDifficulty) String? difficultyLevel,@JsonKey(readValue: _readDuration) num? durationSeconds,@JsonKey(readValue: _readCreatedAt) String? createdAt
});




}
/// @nodoc
class __$MiniGameRecordCopyWithImpl<$Res>
    implements _$MiniGameRecordCopyWith<$Res> {
  __$MiniGameRecordCopyWithImpl(this._self, this._then);

  final _MiniGameRecord _self;
  final $Res Function(_MiniGameRecord) _then;

/// Create a copy of MiniGameRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? gameType = freezed,Object? score = freezed,Object? reactionTimeMs = freezed,Object? accuracyPercentage = freezed,Object? difficultyLevel = freezed,Object? durationSeconds = freezed,Object? createdAt = freezed,}) {
  return _then(_MiniGameRecord(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,gameType: freezed == gameType ? _self.gameType : gameType // ignore: cast_nullable_to_non_nullable
as String?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as num?,reactionTimeMs: freezed == reactionTimeMs ? _self.reactionTimeMs : reactionTimeMs // ignore: cast_nullable_to_non_nullable
as num?,accuracyPercentage: freezed == accuracyPercentage ? _self.accuracyPercentage : accuracyPercentage // ignore: cast_nullable_to_non_nullable
as num?,difficultyLevel: freezed == difficultyLevel ? _self.difficultyLevel : difficultyLevel // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as num?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
