// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_action_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthActionResponse {

 String get status; String get message;@JsonKey(name: 'access_token') String? get accessToken; Object? get data; Object? get errors;
/// Create a copy of AuthActionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthActionResponseCopyWith<AuthActionResponse> get copyWith => _$AuthActionResponseCopyWithImpl<AuthActionResponse>(this as AuthActionResponse, _$identity);

  /// Serializes this AuthActionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthActionResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,accessToken,const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'AuthActionResponse(status: $status, message: $message, accessToken: $accessToken, data: $data, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $AuthActionResponseCopyWith<$Res>  {
  factory $AuthActionResponseCopyWith(AuthActionResponse value, $Res Function(AuthActionResponse) _then) = _$AuthActionResponseCopyWithImpl;
@useResult
$Res call({
 String status, String message,@JsonKey(name: 'access_token') String? accessToken, Object? data, Object? errors
});




}
/// @nodoc
class _$AuthActionResponseCopyWithImpl<$Res>
    implements $AuthActionResponseCopyWith<$Res> {
  _$AuthActionResponseCopyWithImpl(this._self, this._then);

  final AuthActionResponse _self;
  final $Res Function(AuthActionResponse) _then;

/// Create a copy of AuthActionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? message = null,Object? accessToken = freezed,Object? data = freezed,Object? errors = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data ,errors: freezed == errors ? _self.errors : errors ,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthActionResponse].
extension AuthActionResponsePatterns on AuthActionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthActionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthActionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthActionResponse value)  $default,){
final _that = this;
switch (_that) {
case _AuthActionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthActionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AuthActionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String message, @JsonKey(name: 'access_token')  String? accessToken,  Object? data,  Object? errors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthActionResponse() when $default != null:
return $default(_that.status,_that.message,_that.accessToken,_that.data,_that.errors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String message, @JsonKey(name: 'access_token')  String? accessToken,  Object? data,  Object? errors)  $default,) {final _that = this;
switch (_that) {
case _AuthActionResponse():
return $default(_that.status,_that.message,_that.accessToken,_that.data,_that.errors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String message, @JsonKey(name: 'access_token')  String? accessToken,  Object? data,  Object? errors)?  $default,) {final _that = this;
switch (_that) {
case _AuthActionResponse() when $default != null:
return $default(_that.status,_that.message,_that.accessToken,_that.data,_that.errors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthActionResponse implements AuthActionResponse {
  const _AuthActionResponse({this.status = '', this.message = '', @JsonKey(name: 'access_token') this.accessToken, this.data, this.errors});
  factory _AuthActionResponse.fromJson(Map<String, dynamic> json) => _$AuthActionResponseFromJson(json);

@override@JsonKey() final  String status;
@override@JsonKey() final  String message;
@override@JsonKey(name: 'access_token') final  String? accessToken;
@override final  Object? data;
@override final  Object? errors;

/// Create a copy of AuthActionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthActionResponseCopyWith<_AuthActionResponse> get copyWith => __$AuthActionResponseCopyWithImpl<_AuthActionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthActionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthActionResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,accessToken,const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'AuthActionResponse(status: $status, message: $message, accessToken: $accessToken, data: $data, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$AuthActionResponseCopyWith<$Res> implements $AuthActionResponseCopyWith<$Res> {
  factory _$AuthActionResponseCopyWith(_AuthActionResponse value, $Res Function(_AuthActionResponse) _then) = __$AuthActionResponseCopyWithImpl;
@override @useResult
$Res call({
 String status, String message,@JsonKey(name: 'access_token') String? accessToken, Object? data, Object? errors
});




}
/// @nodoc
class __$AuthActionResponseCopyWithImpl<$Res>
    implements _$AuthActionResponseCopyWith<$Res> {
  __$AuthActionResponseCopyWithImpl(this._self, this._then);

  final _AuthActionResponse _self;
  final $Res Function(_AuthActionResponse) _then;

/// Create a copy of AuthActionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? message = null,Object? accessToken = freezed,Object? data = freezed,Object? errors = freezed,}) {
  return _then(_AuthActionResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data ,errors: freezed == errors ? _self.errors : errors ,
  ));
}


}

// dart format on
