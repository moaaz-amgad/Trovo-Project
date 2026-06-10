// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginUser {

 int? get id;@JsonKey(readValue: _readFullName) String? get fullName; String? get email; String? get gender; int? get age;@JsonKey(readValue: _readAvatar) String? get avatar;
/// Create a copy of LoginUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginUserCopyWith<LoginUser> get copyWith => _$LoginUserCopyWithImpl<LoginUser>(this as LoginUser, _$identity);

  /// Serializes this LoginUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginUser&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.age, age) || other.age == age)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,gender,age,avatar);

@override
String toString() {
  return 'LoginUser(id: $id, fullName: $fullName, email: $email, gender: $gender, age: $age, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class $LoginUserCopyWith<$Res>  {
  factory $LoginUserCopyWith(LoginUser value, $Res Function(LoginUser) _then) = _$LoginUserCopyWithImpl;
@useResult
$Res call({
 int? id,@JsonKey(readValue: _readFullName) String? fullName, String? email, String? gender, int? age,@JsonKey(readValue: _readAvatar) String? avatar
});




}
/// @nodoc
class _$LoginUserCopyWithImpl<$Res>
    implements $LoginUserCopyWith<$Res> {
  _$LoginUserCopyWithImpl(this._self, this._then);

  final LoginUser _self;
  final $Res Function(LoginUser) _then;

/// Create a copy of LoginUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? fullName = freezed,Object? email = freezed,Object? gender = freezed,Object? age = freezed,Object? avatar = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginUser].
extension LoginUserPatterns on LoginUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginUser value)  $default,){
final _that = this;
switch (_that) {
case _LoginUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginUser value)?  $default,){
final _that = this;
switch (_that) {
case _LoginUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id, @JsonKey(readValue: _readFullName)  String? fullName,  String? email,  String? gender,  int? age, @JsonKey(readValue: _readAvatar)  String? avatar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginUser() when $default != null:
return $default(_that.id,_that.fullName,_that.email,_that.gender,_that.age,_that.avatar);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id, @JsonKey(readValue: _readFullName)  String? fullName,  String? email,  String? gender,  int? age, @JsonKey(readValue: _readAvatar)  String? avatar)  $default,) {final _that = this;
switch (_that) {
case _LoginUser():
return $default(_that.id,_that.fullName,_that.email,_that.gender,_that.age,_that.avatar);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id, @JsonKey(readValue: _readFullName)  String? fullName,  String? email,  String? gender,  int? age, @JsonKey(readValue: _readAvatar)  String? avatar)?  $default,) {final _that = this;
switch (_that) {
case _LoginUser() when $default != null:
return $default(_that.id,_that.fullName,_that.email,_that.gender,_that.age,_that.avatar);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginUser implements LoginUser {
  const _LoginUser({this.id, @JsonKey(readValue: _readFullName) this.fullName, this.email, this.gender, this.age, @JsonKey(readValue: _readAvatar) this.avatar});
  factory _LoginUser.fromJson(Map<String, dynamic> json) => _$LoginUserFromJson(json);

@override final  int? id;
@override@JsonKey(readValue: _readFullName) final  String? fullName;
@override final  String? email;
@override final  String? gender;
@override final  int? age;
@override@JsonKey(readValue: _readAvatar) final  String? avatar;

/// Create a copy of LoginUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginUserCopyWith<_LoginUser> get copyWith => __$LoginUserCopyWithImpl<_LoginUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginUser&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.age, age) || other.age == age)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,gender,age,avatar);

@override
String toString() {
  return 'LoginUser(id: $id, fullName: $fullName, email: $email, gender: $gender, age: $age, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class _$LoginUserCopyWith<$Res> implements $LoginUserCopyWith<$Res> {
  factory _$LoginUserCopyWith(_LoginUser value, $Res Function(_LoginUser) _then) = __$LoginUserCopyWithImpl;
@override @useResult
$Res call({
 int? id,@JsonKey(readValue: _readFullName) String? fullName, String? email, String? gender, int? age,@JsonKey(readValue: _readAvatar) String? avatar
});




}
/// @nodoc
class __$LoginUserCopyWithImpl<$Res>
    implements _$LoginUserCopyWith<$Res> {
  __$LoginUserCopyWithImpl(this._self, this._then);

  final _LoginUser _self;
  final $Res Function(_LoginUser) _then;

/// Create a copy of LoginUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? fullName = freezed,Object? email = freezed,Object? gender = freezed,Object? age = freezed,Object? avatar = freezed,}) {
  return _then(_LoginUser(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LoginResponseData {

@JsonKey(readValue: _readAccessToken) String? get accessToken;@JsonKey(readValue: _readRefreshToken) String? get refreshToken;@JsonKey(readValue: _readUser) LoginUser? get user;
/// Create a copy of LoginResponseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginResponseDataCopyWith<LoginResponseData> get copyWith => _$LoginResponseDataCopyWithImpl<LoginResponseData>(this as LoginResponseData, _$identity);

  /// Serializes this LoginResponseData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginResponseData&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,user);

@override
String toString() {
  return 'LoginResponseData(accessToken: $accessToken, refreshToken: $refreshToken, user: $user)';
}


}

/// @nodoc
abstract mixin class $LoginResponseDataCopyWith<$Res>  {
  factory $LoginResponseDataCopyWith(LoginResponseData value, $Res Function(LoginResponseData) _then) = _$LoginResponseDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readAccessToken) String? accessToken,@JsonKey(readValue: _readRefreshToken) String? refreshToken,@JsonKey(readValue: _readUser) LoginUser? user
});


$LoginUserCopyWith<$Res>? get user;

}
/// @nodoc
class _$LoginResponseDataCopyWithImpl<$Res>
    implements $LoginResponseDataCopyWith<$Res> {
  _$LoginResponseDataCopyWithImpl(this._self, this._then);

  final LoginResponseData _self;
  final $Res Function(LoginResponseData) _then;

/// Create a copy of LoginResponseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = freezed,Object? refreshToken = freezed,Object? user = freezed,}) {
  return _then(_self.copyWith(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as LoginUser?,
  ));
}
/// Create a copy of LoginResponseData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $LoginUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoginResponseData].
extension LoginResponseDataPatterns on LoginResponseData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginResponseData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginResponseData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginResponseData value)  $default,){
final _that = this;
switch (_that) {
case _LoginResponseData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginResponseData value)?  $default,){
final _that = this;
switch (_that) {
case _LoginResponseData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readAccessToken)  String? accessToken, @JsonKey(readValue: _readRefreshToken)  String? refreshToken, @JsonKey(readValue: _readUser)  LoginUser? user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginResponseData() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readAccessToken)  String? accessToken, @JsonKey(readValue: _readRefreshToken)  String? refreshToken, @JsonKey(readValue: _readUser)  LoginUser? user)  $default,) {final _that = this;
switch (_that) {
case _LoginResponseData():
return $default(_that.accessToken,_that.refreshToken,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readAccessToken)  String? accessToken, @JsonKey(readValue: _readRefreshToken)  String? refreshToken, @JsonKey(readValue: _readUser)  LoginUser? user)?  $default,) {final _that = this;
switch (_that) {
case _LoginResponseData() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginResponseData implements LoginResponseData {
  const _LoginResponseData({@JsonKey(readValue: _readAccessToken) this.accessToken, @JsonKey(readValue: _readRefreshToken) this.refreshToken, @JsonKey(readValue: _readUser) this.user});
  factory _LoginResponseData.fromJson(Map<String, dynamic> json) => _$LoginResponseDataFromJson(json);

@override@JsonKey(readValue: _readAccessToken) final  String? accessToken;
@override@JsonKey(readValue: _readRefreshToken) final  String? refreshToken;
@override@JsonKey(readValue: _readUser) final  LoginUser? user;

/// Create a copy of LoginResponseData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginResponseDataCopyWith<_LoginResponseData> get copyWith => __$LoginResponseDataCopyWithImpl<_LoginResponseData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginResponseDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginResponseData&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,user);

@override
String toString() {
  return 'LoginResponseData(accessToken: $accessToken, refreshToken: $refreshToken, user: $user)';
}


}

/// @nodoc
abstract mixin class _$LoginResponseDataCopyWith<$Res> implements $LoginResponseDataCopyWith<$Res> {
  factory _$LoginResponseDataCopyWith(_LoginResponseData value, $Res Function(_LoginResponseData) _then) = __$LoginResponseDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readAccessToken) String? accessToken,@JsonKey(readValue: _readRefreshToken) String? refreshToken,@JsonKey(readValue: _readUser) LoginUser? user
});


@override $LoginUserCopyWith<$Res>? get user;

}
/// @nodoc
class __$LoginResponseDataCopyWithImpl<$Res>
    implements _$LoginResponseDataCopyWith<$Res> {
  __$LoginResponseDataCopyWithImpl(this._self, this._then);

  final _LoginResponseData _self;
  final $Res Function(_LoginResponseData) _then;

/// Create a copy of LoginResponseData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = freezed,Object? refreshToken = freezed,Object? user = freezed,}) {
  return _then(_LoginResponseData(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as LoginUser?,
  ));
}

/// Create a copy of LoginResponseData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $LoginUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$LoginResponse {

 String get status; String get message; LoginResponseData? get data;@JsonKey(readValue: _readToken) String? get token; Object? get errors;
/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginResponseCopyWith<LoginResponse> get copyWith => _$LoginResponseCopyWithImpl<LoginResponse>(this as LoginResponse, _$identity);

  /// Serializes this LoginResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.token, token) || other.token == token)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,data,token,const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'LoginResponse(status: $status, message: $message, data: $data, token: $token, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $LoginResponseCopyWith<$Res>  {
  factory $LoginResponseCopyWith(LoginResponse value, $Res Function(LoginResponse) _then) = _$LoginResponseCopyWithImpl;
@useResult
$Res call({
 String status, String message, LoginResponseData? data,@JsonKey(readValue: _readToken) String? token, Object? errors
});


$LoginResponseDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$LoginResponseCopyWithImpl<$Res>
    implements $LoginResponseCopyWith<$Res> {
  _$LoginResponseCopyWithImpl(this._self, this._then);

  final LoginResponse _self;
  final $Res Function(LoginResponse) _then;

/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? message = null,Object? data = freezed,Object? token = freezed,Object? errors = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as LoginResponseData?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,errors: freezed == errors ? _self.errors : errors ,
  ));
}
/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginResponseDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $LoginResponseDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoginResponse].
extension LoginResponsePatterns on LoginResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginResponse value)  $default,){
final _that = this;
switch (_that) {
case _LoginResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginResponse value)?  $default,){
final _that = this;
switch (_that) {
case _LoginResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String message,  LoginResponseData? data, @JsonKey(readValue: _readToken)  String? token,  Object? errors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginResponse() when $default != null:
return $default(_that.status,_that.message,_that.data,_that.token,_that.errors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String message,  LoginResponseData? data, @JsonKey(readValue: _readToken)  String? token,  Object? errors)  $default,) {final _that = this;
switch (_that) {
case _LoginResponse():
return $default(_that.status,_that.message,_that.data,_that.token,_that.errors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String message,  LoginResponseData? data, @JsonKey(readValue: _readToken)  String? token,  Object? errors)?  $default,) {final _that = this;
switch (_that) {
case _LoginResponse() when $default != null:
return $default(_that.status,_that.message,_that.data,_that.token,_that.errors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginResponse extends LoginResponse {
  const _LoginResponse({this.status = '', this.message = '', this.data, @JsonKey(readValue: _readToken) this.token, this.errors}): super._();
  factory _LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

@override@JsonKey() final  String status;
@override@JsonKey() final  String message;
@override final  LoginResponseData? data;
@override@JsonKey(readValue: _readToken) final  String? token;
@override final  Object? errors;

/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginResponseCopyWith<_LoginResponse> get copyWith => __$LoginResponseCopyWithImpl<_LoginResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.token, token) || other.token == token)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,data,token,const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'LoginResponse(status: $status, message: $message, data: $data, token: $token, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$LoginResponseCopyWith<$Res> implements $LoginResponseCopyWith<$Res> {
  factory _$LoginResponseCopyWith(_LoginResponse value, $Res Function(_LoginResponse) _then) = __$LoginResponseCopyWithImpl;
@override @useResult
$Res call({
 String status, String message, LoginResponseData? data,@JsonKey(readValue: _readToken) String? token, Object? errors
});


@override $LoginResponseDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$LoginResponseCopyWithImpl<$Res>
    implements _$LoginResponseCopyWith<$Res> {
  __$LoginResponseCopyWithImpl(this._self, this._then);

  final _LoginResponse _self;
  final $Res Function(_LoginResponse) _then;

/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? message = null,Object? data = freezed,Object? token = freezed,Object? errors = freezed,}) {
  return _then(_LoginResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as LoginResponseData?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,errors: freezed == errors ? _self.errors : errors ,
  ));
}

/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginResponseDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $LoginResponseDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
