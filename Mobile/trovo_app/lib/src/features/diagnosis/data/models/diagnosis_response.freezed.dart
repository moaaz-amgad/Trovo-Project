// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnosis_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiagnosisResponse {

 String get status; String get message; Map<String, dynamic>? get data; Object? get errors;
/// Create a copy of DiagnosisResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagnosisResponseCopyWith<DiagnosisResponse> get copyWith => _$DiagnosisResponseCopyWithImpl<DiagnosisResponse>(this as DiagnosisResponse, _$identity);

  /// Serializes this DiagnosisResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagnosisResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'DiagnosisResponse(status: $status, message: $message, data: $data, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $DiagnosisResponseCopyWith<$Res>  {
  factory $DiagnosisResponseCopyWith(DiagnosisResponse value, $Res Function(DiagnosisResponse) _then) = _$DiagnosisResponseCopyWithImpl;
@useResult
$Res call({
 String status, String message, Map<String, dynamic>? data, Object? errors
});




}
/// @nodoc
class _$DiagnosisResponseCopyWithImpl<$Res>
    implements $DiagnosisResponseCopyWith<$Res> {
  _$DiagnosisResponseCopyWithImpl(this._self, this._then);

  final DiagnosisResponse _self;
  final $Res Function(DiagnosisResponse) _then;

/// Create a copy of DiagnosisResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? message = null,Object? data = freezed,Object? errors = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,errors: freezed == errors ? _self.errors : errors ,
  ));
}

}


/// Adds pattern-matching-related methods to [DiagnosisResponse].
extension DiagnosisResponsePatterns on DiagnosisResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiagnosisResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiagnosisResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiagnosisResponse value)  $default,){
final _that = this;
switch (_that) {
case _DiagnosisResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiagnosisResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DiagnosisResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String message,  Map<String, dynamic>? data,  Object? errors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiagnosisResponse() when $default != null:
return $default(_that.status,_that.message,_that.data,_that.errors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String message,  Map<String, dynamic>? data,  Object? errors)  $default,) {final _that = this;
switch (_that) {
case _DiagnosisResponse():
return $default(_that.status,_that.message,_that.data,_that.errors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String message,  Map<String, dynamic>? data,  Object? errors)?  $default,) {final _that = this;
switch (_that) {
case _DiagnosisResponse() when $default != null:
return $default(_that.status,_that.message,_that.data,_that.errors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiagnosisResponse implements DiagnosisResponse {
  const _DiagnosisResponse({this.status = '', this.message = '', final  Map<String, dynamic>? data, this.errors}): _data = data;
  factory _DiagnosisResponse.fromJson(Map<String, dynamic> json) => _$DiagnosisResponseFromJson(json);

@override@JsonKey() final  String status;
@override@JsonKey() final  String message;
 final  Map<String, dynamic>? _data;
@override Map<String, dynamic>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  Object? errors;

/// Create a copy of DiagnosisResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiagnosisResponseCopyWith<_DiagnosisResponse> get copyWith => __$DiagnosisResponseCopyWithImpl<_DiagnosisResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiagnosisResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagnosisResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._data, _data)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,const DeepCollectionEquality().hash(_data),const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'DiagnosisResponse(status: $status, message: $message, data: $data, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$DiagnosisResponseCopyWith<$Res> implements $DiagnosisResponseCopyWith<$Res> {
  factory _$DiagnosisResponseCopyWith(_DiagnosisResponse value, $Res Function(_DiagnosisResponse) _then) = __$DiagnosisResponseCopyWithImpl;
@override @useResult
$Res call({
 String status, String message, Map<String, dynamic>? data, Object? errors
});




}
/// @nodoc
class __$DiagnosisResponseCopyWithImpl<$Res>
    implements _$DiagnosisResponseCopyWith<$Res> {
  __$DiagnosisResponseCopyWithImpl(this._self, this._then);

  final _DiagnosisResponse _self;
  final $Res Function(_DiagnosisResponse) _then;

/// Create a copy of DiagnosisResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? message = null,Object? data = freezed,Object? errors = freezed,}) {
  return _then(_DiagnosisResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,errors: freezed == errors ? _self.errors : errors ,
  ));
}


}

// dart format on
