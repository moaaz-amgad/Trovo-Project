// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProgressEntry {

 int? get id;@JsonKey(readValue: _readScore) num? get score;@JsonKey(readValue: _readDate) String? get date;@JsonKey(readValue: _readLabel) String? get label;
/// Create a copy of ProgressEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressEntryCopyWith<ProgressEntry> get copyWith => _$ProgressEntryCopyWithImpl<ProgressEntry>(this as ProgressEntry, _$identity);

  /// Serializes this ProgressEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.score, score) || other.score == score)&&(identical(other.date, date) || other.date == date)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,score,date,label);

@override
String toString() {
  return 'ProgressEntry(id: $id, score: $score, date: $date, label: $label)';
}


}

/// @nodoc
abstract mixin class $ProgressEntryCopyWith<$Res>  {
  factory $ProgressEntryCopyWith(ProgressEntry value, $Res Function(ProgressEntry) _then) = _$ProgressEntryCopyWithImpl;
@useResult
$Res call({
 int? id,@JsonKey(readValue: _readScore) num? score,@JsonKey(readValue: _readDate) String? date,@JsonKey(readValue: _readLabel) String? label
});




}
/// @nodoc
class _$ProgressEntryCopyWithImpl<$Res>
    implements $ProgressEntryCopyWith<$Res> {
  _$ProgressEntryCopyWithImpl(this._self, this._then);

  final ProgressEntry _self;
  final $Res Function(ProgressEntry) _then;

/// Create a copy of ProgressEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? score = freezed,Object? date = freezed,Object? label = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as num?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProgressEntry].
extension ProgressEntryPatterns on ProgressEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProgressEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgressEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProgressEntry value)  $default,){
final _that = this;
switch (_that) {
case _ProgressEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProgressEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ProgressEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id, @JsonKey(readValue: _readScore)  num? score, @JsonKey(readValue: _readDate)  String? date, @JsonKey(readValue: _readLabel)  String? label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgressEntry() when $default != null:
return $default(_that.id,_that.score,_that.date,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id, @JsonKey(readValue: _readScore)  num? score, @JsonKey(readValue: _readDate)  String? date, @JsonKey(readValue: _readLabel)  String? label)  $default,) {final _that = this;
switch (_that) {
case _ProgressEntry():
return $default(_that.id,_that.score,_that.date,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id, @JsonKey(readValue: _readScore)  num? score, @JsonKey(readValue: _readDate)  String? date, @JsonKey(readValue: _readLabel)  String? label)?  $default,) {final _that = this;
switch (_that) {
case _ProgressEntry() when $default != null:
return $default(_that.id,_that.score,_that.date,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProgressEntry implements ProgressEntry {
  const _ProgressEntry({this.id, @JsonKey(readValue: _readScore) this.score, @JsonKey(readValue: _readDate) this.date, @JsonKey(readValue: _readLabel) this.label});
  factory _ProgressEntry.fromJson(Map<String, dynamic> json) => _$ProgressEntryFromJson(json);

@override final  int? id;
@override@JsonKey(readValue: _readScore) final  num? score;
@override@JsonKey(readValue: _readDate) final  String? date;
@override@JsonKey(readValue: _readLabel) final  String? label;

/// Create a copy of ProgressEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressEntryCopyWith<_ProgressEntry> get copyWith => __$ProgressEntryCopyWithImpl<_ProgressEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgressEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.score, score) || other.score == score)&&(identical(other.date, date) || other.date == date)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,score,date,label);

@override
String toString() {
  return 'ProgressEntry(id: $id, score: $score, date: $date, label: $label)';
}


}

/// @nodoc
abstract mixin class _$ProgressEntryCopyWith<$Res> implements $ProgressEntryCopyWith<$Res> {
  factory _$ProgressEntryCopyWith(_ProgressEntry value, $Res Function(_ProgressEntry) _then) = __$ProgressEntryCopyWithImpl;
@override @useResult
$Res call({
 int? id,@JsonKey(readValue: _readScore) num? score,@JsonKey(readValue: _readDate) String? date,@JsonKey(readValue: _readLabel) String? label
});




}
/// @nodoc
class __$ProgressEntryCopyWithImpl<$Res>
    implements _$ProgressEntryCopyWith<$Res> {
  __$ProgressEntryCopyWithImpl(this._self, this._then);

  final _ProgressEntry _self;
  final $Res Function(_ProgressEntry) _then;

/// Create a copy of ProgressEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? score = freezed,Object? date = freezed,Object? label = freezed,}) {
  return _then(_ProgressEntry(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as num?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
