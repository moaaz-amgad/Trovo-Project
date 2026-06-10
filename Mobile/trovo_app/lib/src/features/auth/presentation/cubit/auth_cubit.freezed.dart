// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _AuthInitial value)?  initial,TResult Function( _AuthLoading value)?  loading,TResult Function( _AuthLoginSuccess value)?  loginSuccess,TResult Function( _AuthRegisterSuccess value)?  registerSuccess,TResult Function( _AuthVerifyEmailSuccess value)?  verifyEmailSuccess,TResult Function( _AuthOtpResentSuccess value)?  otpResentSuccess,TResult Function( _AuthForgotPasswordSuccess value)?  forgotPasswordSuccess,TResult Function( _AuthResetPasswordSuccess value)?  resetPasswordSuccess,TResult Function( _AuthEmailNotVerified value)?  emailNotVerified,TResult Function( _AuthError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthInitial() when initial != null:
return initial(_that);case _AuthLoading() when loading != null:
return loading(_that);case _AuthLoginSuccess() when loginSuccess != null:
return loginSuccess(_that);case _AuthRegisterSuccess() when registerSuccess != null:
return registerSuccess(_that);case _AuthVerifyEmailSuccess() when verifyEmailSuccess != null:
return verifyEmailSuccess(_that);case _AuthOtpResentSuccess() when otpResentSuccess != null:
return otpResentSuccess(_that);case _AuthForgotPasswordSuccess() when forgotPasswordSuccess != null:
return forgotPasswordSuccess(_that);case _AuthResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that);case _AuthEmailNotVerified() when emailNotVerified != null:
return emailNotVerified(_that);case _AuthError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _AuthInitial value)  initial,required TResult Function( _AuthLoading value)  loading,required TResult Function( _AuthLoginSuccess value)  loginSuccess,required TResult Function( _AuthRegisterSuccess value)  registerSuccess,required TResult Function( _AuthVerifyEmailSuccess value)  verifyEmailSuccess,required TResult Function( _AuthOtpResentSuccess value)  otpResentSuccess,required TResult Function( _AuthForgotPasswordSuccess value)  forgotPasswordSuccess,required TResult Function( _AuthResetPasswordSuccess value)  resetPasswordSuccess,required TResult Function( _AuthEmailNotVerified value)  emailNotVerified,required TResult Function( _AuthError value)  error,}){
final _that = this;
switch (_that) {
case _AuthInitial():
return initial(_that);case _AuthLoading():
return loading(_that);case _AuthLoginSuccess():
return loginSuccess(_that);case _AuthRegisterSuccess():
return registerSuccess(_that);case _AuthVerifyEmailSuccess():
return verifyEmailSuccess(_that);case _AuthOtpResentSuccess():
return otpResentSuccess(_that);case _AuthForgotPasswordSuccess():
return forgotPasswordSuccess(_that);case _AuthResetPasswordSuccess():
return resetPasswordSuccess(_that);case _AuthEmailNotVerified():
return emailNotVerified(_that);case _AuthError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _AuthInitial value)?  initial,TResult? Function( _AuthLoading value)?  loading,TResult? Function( _AuthLoginSuccess value)?  loginSuccess,TResult? Function( _AuthRegisterSuccess value)?  registerSuccess,TResult? Function( _AuthVerifyEmailSuccess value)?  verifyEmailSuccess,TResult? Function( _AuthOtpResentSuccess value)?  otpResentSuccess,TResult? Function( _AuthForgotPasswordSuccess value)?  forgotPasswordSuccess,TResult? Function( _AuthResetPasswordSuccess value)?  resetPasswordSuccess,TResult? Function( _AuthEmailNotVerified value)?  emailNotVerified,TResult? Function( _AuthError value)?  error,}){
final _that = this;
switch (_that) {
case _AuthInitial() when initial != null:
return initial(_that);case _AuthLoading() when loading != null:
return loading(_that);case _AuthLoginSuccess() when loginSuccess != null:
return loginSuccess(_that);case _AuthRegisterSuccess() when registerSuccess != null:
return registerSuccess(_that);case _AuthVerifyEmailSuccess() when verifyEmailSuccess != null:
return verifyEmailSuccess(_that);case _AuthOtpResentSuccess() when otpResentSuccess != null:
return otpResentSuccess(_that);case _AuthForgotPasswordSuccess() when forgotPasswordSuccess != null:
return forgotPasswordSuccess(_that);case _AuthResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that);case _AuthEmailNotVerified() when emailNotVerified != null:
return emailNotVerified(_that);case _AuthError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( LoginResponse data)?  loginSuccess,TResult Function( RegisterResponse data)?  registerSuccess,TResult Function( String message)?  verifyEmailSuccess,TResult Function( String message)?  otpResentSuccess,TResult Function( String email,  String message)?  forgotPasswordSuccess,TResult Function( String message)?  resetPasswordSuccess,TResult Function( String email)?  emailNotVerified,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthInitial() when initial != null:
return initial();case _AuthLoading() when loading != null:
return loading();case _AuthLoginSuccess() when loginSuccess != null:
return loginSuccess(_that.data);case _AuthRegisterSuccess() when registerSuccess != null:
return registerSuccess(_that.data);case _AuthVerifyEmailSuccess() when verifyEmailSuccess != null:
return verifyEmailSuccess(_that.message);case _AuthOtpResentSuccess() when otpResentSuccess != null:
return otpResentSuccess(_that.message);case _AuthForgotPasswordSuccess() when forgotPasswordSuccess != null:
return forgotPasswordSuccess(_that.email,_that.message);case _AuthResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that.message);case _AuthEmailNotVerified() when emailNotVerified != null:
return emailNotVerified(_that.email);case _AuthError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( LoginResponse data)  loginSuccess,required TResult Function( RegisterResponse data)  registerSuccess,required TResult Function( String message)  verifyEmailSuccess,required TResult Function( String message)  otpResentSuccess,required TResult Function( String email,  String message)  forgotPasswordSuccess,required TResult Function( String message)  resetPasswordSuccess,required TResult Function( String email)  emailNotVerified,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _AuthInitial():
return initial();case _AuthLoading():
return loading();case _AuthLoginSuccess():
return loginSuccess(_that.data);case _AuthRegisterSuccess():
return registerSuccess(_that.data);case _AuthVerifyEmailSuccess():
return verifyEmailSuccess(_that.message);case _AuthOtpResentSuccess():
return otpResentSuccess(_that.message);case _AuthForgotPasswordSuccess():
return forgotPasswordSuccess(_that.email,_that.message);case _AuthResetPasswordSuccess():
return resetPasswordSuccess(_that.message);case _AuthEmailNotVerified():
return emailNotVerified(_that.email);case _AuthError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( LoginResponse data)?  loginSuccess,TResult? Function( RegisterResponse data)?  registerSuccess,TResult? Function( String message)?  verifyEmailSuccess,TResult? Function( String message)?  otpResentSuccess,TResult? Function( String email,  String message)?  forgotPasswordSuccess,TResult? Function( String message)?  resetPasswordSuccess,TResult? Function( String email)?  emailNotVerified,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _AuthInitial() when initial != null:
return initial();case _AuthLoading() when loading != null:
return loading();case _AuthLoginSuccess() when loginSuccess != null:
return loginSuccess(_that.data);case _AuthRegisterSuccess() when registerSuccess != null:
return registerSuccess(_that.data);case _AuthVerifyEmailSuccess() when verifyEmailSuccess != null:
return verifyEmailSuccess(_that.message);case _AuthOtpResentSuccess() when otpResentSuccess != null:
return otpResentSuccess(_that.message);case _AuthForgotPasswordSuccess() when forgotPasswordSuccess != null:
return forgotPasswordSuccess(_that.email,_that.message);case _AuthResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that.message);case _AuthEmailNotVerified() when emailNotVerified != null:
return emailNotVerified(_that.email);case _AuthError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _AuthInitial implements AuthState {
  const _AuthInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.initial()';
}


}




/// @nodoc


class _AuthLoading implements AuthState {
  const _AuthLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loading()';
}


}




/// @nodoc


class _AuthLoginSuccess implements AuthState {
  const _AuthLoginSuccess(this.data);
  

 final  LoginResponse data;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthLoginSuccessCopyWith<_AuthLoginSuccess> get copyWith => __$AuthLoginSuccessCopyWithImpl<_AuthLoginSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthLoginSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'AuthState.loginSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class _$AuthLoginSuccessCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthLoginSuccessCopyWith(_AuthLoginSuccess value, $Res Function(_AuthLoginSuccess) _then) = __$AuthLoginSuccessCopyWithImpl;
@useResult
$Res call({
 LoginResponse data
});


$LoginResponseCopyWith<$Res> get data;

}
/// @nodoc
class __$AuthLoginSuccessCopyWithImpl<$Res>
    implements _$AuthLoginSuccessCopyWith<$Res> {
  __$AuthLoginSuccessCopyWithImpl(this._self, this._then);

  final _AuthLoginSuccess _self;
  final $Res Function(_AuthLoginSuccess) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_AuthLoginSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as LoginResponse,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginResponseCopyWith<$Res> get data {
  
  return $LoginResponseCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _AuthRegisterSuccess implements AuthState {
  const _AuthRegisterSuccess(this.data);
  

 final  RegisterResponse data;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthRegisterSuccessCopyWith<_AuthRegisterSuccess> get copyWith => __$AuthRegisterSuccessCopyWithImpl<_AuthRegisterSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthRegisterSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'AuthState.registerSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class _$AuthRegisterSuccessCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthRegisterSuccessCopyWith(_AuthRegisterSuccess value, $Res Function(_AuthRegisterSuccess) _then) = __$AuthRegisterSuccessCopyWithImpl;
@useResult
$Res call({
 RegisterResponse data
});


$RegisterResponseCopyWith<$Res> get data;

}
/// @nodoc
class __$AuthRegisterSuccessCopyWithImpl<$Res>
    implements _$AuthRegisterSuccessCopyWith<$Res> {
  __$AuthRegisterSuccessCopyWithImpl(this._self, this._then);

  final _AuthRegisterSuccess _self;
  final $Res Function(_AuthRegisterSuccess) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_AuthRegisterSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RegisterResponse,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegisterResponseCopyWith<$Res> get data {
  
  return $RegisterResponseCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _AuthVerifyEmailSuccess implements AuthState {
  const _AuthVerifyEmailSuccess(this.message);
  

 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthVerifyEmailSuccessCopyWith<_AuthVerifyEmailSuccess> get copyWith => __$AuthVerifyEmailSuccessCopyWithImpl<_AuthVerifyEmailSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthVerifyEmailSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.verifyEmailSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class _$AuthVerifyEmailSuccessCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthVerifyEmailSuccessCopyWith(_AuthVerifyEmailSuccess value, $Res Function(_AuthVerifyEmailSuccess) _then) = __$AuthVerifyEmailSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$AuthVerifyEmailSuccessCopyWithImpl<$Res>
    implements _$AuthVerifyEmailSuccessCopyWith<$Res> {
  __$AuthVerifyEmailSuccessCopyWithImpl(this._self, this._then);

  final _AuthVerifyEmailSuccess _self;
  final $Res Function(_AuthVerifyEmailSuccess) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_AuthVerifyEmailSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AuthOtpResentSuccess implements AuthState {
  const _AuthOtpResentSuccess(this.message);
  

 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthOtpResentSuccessCopyWith<_AuthOtpResentSuccess> get copyWith => __$AuthOtpResentSuccessCopyWithImpl<_AuthOtpResentSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthOtpResentSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.otpResentSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class _$AuthOtpResentSuccessCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthOtpResentSuccessCopyWith(_AuthOtpResentSuccess value, $Res Function(_AuthOtpResentSuccess) _then) = __$AuthOtpResentSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$AuthOtpResentSuccessCopyWithImpl<$Res>
    implements _$AuthOtpResentSuccessCopyWith<$Res> {
  __$AuthOtpResentSuccessCopyWithImpl(this._self, this._then);

  final _AuthOtpResentSuccess _self;
  final $Res Function(_AuthOtpResentSuccess) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_AuthOtpResentSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AuthForgotPasswordSuccess implements AuthState {
  const _AuthForgotPasswordSuccess({required this.email, required this.message});
  

 final  String email;
 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthForgotPasswordSuccessCopyWith<_AuthForgotPasswordSuccess> get copyWith => __$AuthForgotPasswordSuccessCopyWithImpl<_AuthForgotPasswordSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthForgotPasswordSuccess&&(identical(other.email, email) || other.email == email)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,email,message);

@override
String toString() {
  return 'AuthState.forgotPasswordSuccess(email: $email, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AuthForgotPasswordSuccessCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthForgotPasswordSuccessCopyWith(_AuthForgotPasswordSuccess value, $Res Function(_AuthForgotPasswordSuccess) _then) = __$AuthForgotPasswordSuccessCopyWithImpl;
@useResult
$Res call({
 String email, String message
});




}
/// @nodoc
class __$AuthForgotPasswordSuccessCopyWithImpl<$Res>
    implements _$AuthForgotPasswordSuccessCopyWith<$Res> {
  __$AuthForgotPasswordSuccessCopyWithImpl(this._self, this._then);

  final _AuthForgotPasswordSuccess _self;
  final $Res Function(_AuthForgotPasswordSuccess) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? message = null,}) {
  return _then(_AuthForgotPasswordSuccess(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AuthResetPasswordSuccess implements AuthState {
  const _AuthResetPasswordSuccess(this.message);
  

 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthResetPasswordSuccessCopyWith<_AuthResetPasswordSuccess> get copyWith => __$AuthResetPasswordSuccessCopyWithImpl<_AuthResetPasswordSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthResetPasswordSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.resetPasswordSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class _$AuthResetPasswordSuccessCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthResetPasswordSuccessCopyWith(_AuthResetPasswordSuccess value, $Res Function(_AuthResetPasswordSuccess) _then) = __$AuthResetPasswordSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$AuthResetPasswordSuccessCopyWithImpl<$Res>
    implements _$AuthResetPasswordSuccessCopyWith<$Res> {
  __$AuthResetPasswordSuccessCopyWithImpl(this._self, this._then);

  final _AuthResetPasswordSuccess _self;
  final $Res Function(_AuthResetPasswordSuccess) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_AuthResetPasswordSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AuthEmailNotVerified implements AuthState {
  const _AuthEmailNotVerified(this.email);
  

 final  String email;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthEmailNotVerifiedCopyWith<_AuthEmailNotVerified> get copyWith => __$AuthEmailNotVerifiedCopyWithImpl<_AuthEmailNotVerified>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthEmailNotVerified&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthState.emailNotVerified(email: $email)';
}


}

/// @nodoc
abstract mixin class _$AuthEmailNotVerifiedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthEmailNotVerifiedCopyWith(_AuthEmailNotVerified value, $Res Function(_AuthEmailNotVerified) _then) = __$AuthEmailNotVerifiedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$AuthEmailNotVerifiedCopyWithImpl<$Res>
    implements _$AuthEmailNotVerifiedCopyWith<$Res> {
  __$AuthEmailNotVerifiedCopyWithImpl(this._self, this._then);

  final _AuthEmailNotVerified _self;
  final $Res Function(_AuthEmailNotVerified) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_AuthEmailNotVerified(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AuthError implements AuthState {
  const _AuthError(this.message);
  

 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthErrorCopyWith<_AuthError> get copyWith => __$AuthErrorCopyWithImpl<_AuthError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$AuthErrorCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthErrorCopyWith(_AuthError value, $Res Function(_AuthError) _then) = __$AuthErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$AuthErrorCopyWithImpl<$Res>
    implements _$AuthErrorCopyWith<$Res> {
  __$AuthErrorCopyWithImpl(this._self, this._then);

  final _AuthError _self;
  final $Res Function(_AuthError) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_AuthError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
