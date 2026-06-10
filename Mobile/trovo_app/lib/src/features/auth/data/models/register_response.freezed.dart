// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegisterUser {

 int? get id;@JsonKey(readValue: _readFullName) String? get fullName; String? get email; String? get gender; int? get age;
/// Create a copy of RegisterUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterUserCopyWith<RegisterUser> get copyWith => _$RegisterUserCopyWithImpl<RegisterUser>(this as RegisterUser, _$identity);

  /// Serializes this RegisterUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterUser&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.age, age) || other.age == age));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,gender,age);

@override
String toString() {
  return 'RegisterUser(id: $id, fullName: $fullName, email: $email, gender: $gender, age: $age)';
}


}

/// @nodoc
abstract mixin class $RegisterUserCopyWith<$Res>  {
  factory $RegisterUserCopyWith(RegisterUser value, $Res Function(RegisterUser) _then) = _$RegisterUserCopyWithImpl;
@useResult
$Res call({
 int? id,@JsonKey(readValue: _readFullName) String? fullName, String? email, String? gender, int? age
});




}
/// @nodoc
class _$RegisterUserCopyWithImpl<$Res>
    implements $RegisterUserCopyWith<$Res> {
  _$RegisterUserCopyWithImpl(this._self, this._then);

  final RegisterUser _self;
  final $Res Function(RegisterUser) _then;

/// Create a copy of RegisterUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? fullName = freezed,Object? email = freezed,Object? gender = freezed,Object? age = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterUser].
extension RegisterUserPatterns on RegisterUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterUser value)  $default,){
final _that = this;
switch (_that) {
case _RegisterUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterUser value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id, @JsonKey(readValue: _readFullName)  String? fullName,  String? email,  String? gender,  int? age)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterUser() when $default != null:
return $default(_that.id,_that.fullName,_that.email,_that.gender,_that.age);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id, @JsonKey(readValue: _readFullName)  String? fullName,  String? email,  String? gender,  int? age)  $default,) {final _that = this;
switch (_that) {
case _RegisterUser():
return $default(_that.id,_that.fullName,_that.email,_that.gender,_that.age);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id, @JsonKey(readValue: _readFullName)  String? fullName,  String? email,  String? gender,  int? age)?  $default,) {final _that = this;
switch (_that) {
case _RegisterUser() when $default != null:
return $default(_that.id,_that.fullName,_that.email,_that.gender,_that.age);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterUser implements RegisterUser {
  const _RegisterUser({this.id, @JsonKey(readValue: _readFullName) this.fullName, this.email, this.gender, this.age});
  factory _RegisterUser.fromJson(Map<String, dynamic> json) => _$RegisterUserFromJson(json);

@override final  int? id;
@override@JsonKey(readValue: _readFullName) final  String? fullName;
@override final  String? email;
@override final  String? gender;
@override final  int? age;

/// Create a copy of RegisterUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterUserCopyWith<_RegisterUser> get copyWith => __$RegisterUserCopyWithImpl<_RegisterUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterUser&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.age, age) || other.age == age));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,gender,age);

@override
String toString() {
  return 'RegisterUser(id: $id, fullName: $fullName, email: $email, gender: $gender, age: $age)';
}


}

/// @nodoc
abstract mixin class _$RegisterUserCopyWith<$Res> implements $RegisterUserCopyWith<$Res> {
  factory _$RegisterUserCopyWith(_RegisterUser value, $Res Function(_RegisterUser) _then) = __$RegisterUserCopyWithImpl;
@override @useResult
$Res call({
 int? id,@JsonKey(readValue: _readFullName) String? fullName, String? email, String? gender, int? age
});




}
/// @nodoc
class __$RegisterUserCopyWithImpl<$Res>
    implements _$RegisterUserCopyWith<$Res> {
  __$RegisterUserCopyWithImpl(this._self, this._then);

  final _RegisterUser _self;
  final $Res Function(_RegisterUser) _then;

/// Create a copy of RegisterUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? fullName = freezed,Object? email = freezed,Object? gender = freezed,Object? age = freezed,}) {
  return _then(_RegisterUser(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$RegisterResponse {

 String get status; String get message;@JsonKey(readValue: _readUser) RegisterUser? get data;@JsonKey(name: 'access_token') String? get accessToken;@JsonKey(name: 'token_type') String? get tokenType;@JsonKey(name: 'email_verified') bool? get emailVerified; Object? get errors;
/// Create a copy of RegisterResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterResponseCopyWith<RegisterResponse> get copyWith => _$RegisterResponseCopyWithImpl<RegisterResponse>(this as RegisterResponse, _$identity);

  /// Serializes this RegisterResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,data,accessToken,tokenType,emailVerified,const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'RegisterResponse(status: $status, message: $message, data: $data, accessToken: $accessToken, tokenType: $tokenType, emailVerified: $emailVerified, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $RegisterResponseCopyWith<$Res>  {
  factory $RegisterResponseCopyWith(RegisterResponse value, $Res Function(RegisterResponse) _then) = _$RegisterResponseCopyWithImpl;
@useResult
$Res call({
 String status, String message,@JsonKey(readValue: _readUser) RegisterUser? data,@JsonKey(name: 'access_token') String? accessToken,@JsonKey(name: 'token_type') String? tokenType,@JsonKey(name: 'email_verified') bool? emailVerified, Object? errors
});


$RegisterUserCopyWith<$Res>? get data;

}
/// @nodoc
class _$RegisterResponseCopyWithImpl<$Res>
    implements $RegisterResponseCopyWith<$Res> {
  _$RegisterResponseCopyWithImpl(this._self, this._then);

  final RegisterResponse _self;
  final $Res Function(RegisterResponse) _then;

/// Create a copy of RegisterResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? message = null,Object? data = freezed,Object? accessToken = freezed,Object? tokenType = freezed,Object? emailVerified = freezed,Object? errors = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RegisterUser?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,tokenType: freezed == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String?,emailVerified: freezed == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool?,errors: freezed == errors ? _self.errors : errors ,
  ));
}
/// Create a copy of RegisterResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegisterUserCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $RegisterUserCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [RegisterResponse].
extension RegisterResponsePatterns on RegisterResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterResponse value)  $default,){
final _that = this;
switch (_that) {
case _RegisterResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String message, @JsonKey(readValue: _readUser)  RegisterUser? data, @JsonKey(name: 'access_token')  String? accessToken, @JsonKey(name: 'token_type')  String? tokenType, @JsonKey(name: 'email_verified')  bool? emailVerified,  Object? errors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterResponse() when $default != null:
return $default(_that.status,_that.message,_that.data,_that.accessToken,_that.tokenType,_that.emailVerified,_that.errors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String message, @JsonKey(readValue: _readUser)  RegisterUser? data, @JsonKey(name: 'access_token')  String? accessToken, @JsonKey(name: 'token_type')  String? tokenType, @JsonKey(name: 'email_verified')  bool? emailVerified,  Object? errors)  $default,) {final _that = this;
switch (_that) {
case _RegisterResponse():
return $default(_that.status,_that.message,_that.data,_that.accessToken,_that.tokenType,_that.emailVerified,_that.errors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String message, @JsonKey(readValue: _readUser)  RegisterUser? data, @JsonKey(name: 'access_token')  String? accessToken, @JsonKey(name: 'token_type')  String? tokenType, @JsonKey(name: 'email_verified')  bool? emailVerified,  Object? errors)?  $default,) {final _that = this;
switch (_that) {
case _RegisterResponse() when $default != null:
return $default(_that.status,_that.message,_that.data,_that.accessToken,_that.tokenType,_that.emailVerified,_that.errors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterResponse implements RegisterResponse {
  const _RegisterResponse({this.status = '', this.message = '', @JsonKey(readValue: _readUser) this.data, @JsonKey(name: 'access_token') this.accessToken, @JsonKey(name: 'token_type') this.tokenType, @JsonKey(name: 'email_verified') this.emailVerified, this.errors});
  factory _RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);

@override@JsonKey() final  String status;
@override@JsonKey() final  String message;
@override@JsonKey(readValue: _readUser) final  RegisterUser? data;
@override@JsonKey(name: 'access_token') final  String? accessToken;
@override@JsonKey(name: 'token_type') final  String? tokenType;
@override@JsonKey(name: 'email_verified') final  bool? emailVerified;
@override final  Object? errors;

/// Create a copy of RegisterResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterResponseCopyWith<_RegisterResponse> get copyWith => __$RegisterResponseCopyWithImpl<_RegisterResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,data,accessToken,tokenType,emailVerified,const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'RegisterResponse(status: $status, message: $message, data: $data, accessToken: $accessToken, tokenType: $tokenType, emailVerified: $emailVerified, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$RegisterResponseCopyWith<$Res> implements $RegisterResponseCopyWith<$Res> {
  factory _$RegisterResponseCopyWith(_RegisterResponse value, $Res Function(_RegisterResponse) _then) = __$RegisterResponseCopyWithImpl;
@override @useResult
$Res call({
 String status, String message,@JsonKey(readValue: _readUser) RegisterUser? data,@JsonKey(name: 'access_token') String? accessToken,@JsonKey(name: 'token_type') String? tokenType,@JsonKey(name: 'email_verified') bool? emailVerified, Object? errors
});


@override $RegisterUserCopyWith<$Res>? get data;

}
/// @nodoc
class __$RegisterResponseCopyWithImpl<$Res>
    implements _$RegisterResponseCopyWith<$Res> {
  __$RegisterResponseCopyWithImpl(this._self, this._then);

  final _RegisterResponse _self;
  final $Res Function(_RegisterResponse) _then;

/// Create a copy of RegisterResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? message = null,Object? data = freezed,Object? accessToken = freezed,Object? tokenType = freezed,Object? emailVerified = freezed,Object? errors = freezed,}) {
  return _then(_RegisterResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RegisterUser?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,tokenType: freezed == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String?,emailVerified: freezed == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool?,errors: freezed == errors ? _self.errors : errors ,
  ));
}

/// Create a copy of RegisterResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegisterUserCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $RegisterUserCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
