// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserState()';
}


}

/// @nodoc
class $UserStateCopyWith<$Res>  {
$UserStateCopyWith(UserState _, $Res Function(UserState) __);
}


/// Adds pattern-matching-related methods to [UserState].
extension UserStatePatterns on UserState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _UserInitial value)?  initial,TResult Function( _UserLoading value)?  loading,TResult Function( _UserLoaded value)?  loaded,TResult Function( _UserActionInProgress value)?  actionInProgress,TResult Function( _UserActionSuccess value)?  actionSuccess,TResult Function( _UserAccountDeleted value)?  accountDeleted,TResult Function( _UserError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserInitial() when initial != null:
return initial(_that);case _UserLoading() when loading != null:
return loading(_that);case _UserLoaded() when loaded != null:
return loaded(_that);case _UserActionInProgress() when actionInProgress != null:
return actionInProgress(_that);case _UserActionSuccess() when actionSuccess != null:
return actionSuccess(_that);case _UserAccountDeleted() when accountDeleted != null:
return accountDeleted(_that);case _UserError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _UserInitial value)  initial,required TResult Function( _UserLoading value)  loading,required TResult Function( _UserLoaded value)  loaded,required TResult Function( _UserActionInProgress value)  actionInProgress,required TResult Function( _UserActionSuccess value)  actionSuccess,required TResult Function( _UserAccountDeleted value)  accountDeleted,required TResult Function( _UserError value)  error,}){
final _that = this;
switch (_that) {
case _UserInitial():
return initial(_that);case _UserLoading():
return loading(_that);case _UserLoaded():
return loaded(_that);case _UserActionInProgress():
return actionInProgress(_that);case _UserActionSuccess():
return actionSuccess(_that);case _UserAccountDeleted():
return accountDeleted(_that);case _UserError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _UserInitial value)?  initial,TResult? Function( _UserLoading value)?  loading,TResult? Function( _UserLoaded value)?  loaded,TResult? Function( _UserActionInProgress value)?  actionInProgress,TResult? Function( _UserActionSuccess value)?  actionSuccess,TResult? Function( _UserAccountDeleted value)?  accountDeleted,TResult? Function( _UserError value)?  error,}){
final _that = this;
switch (_that) {
case _UserInitial() when initial != null:
return initial(_that);case _UserLoading() when loading != null:
return loading(_that);case _UserLoaded() when loaded != null:
return loaded(_that);case _UserActionInProgress() when actionInProgress != null:
return actionInProgress(_that);case _UserActionSuccess() when actionSuccess != null:
return actionSuccess(_that);case _UserAccountDeleted() when accountDeleted != null:
return accountDeleted(_that);case _UserError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( UserProfile profile)?  loaded,TResult Function( UserProfile? profile)?  actionInProgress,TResult Function( UserProfile? profile,  String message)?  actionSuccess,TResult Function( String message)?  accountDeleted,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserInitial() when initial != null:
return initial();case _UserLoading() when loading != null:
return loading();case _UserLoaded() when loaded != null:
return loaded(_that.profile);case _UserActionInProgress() when actionInProgress != null:
return actionInProgress(_that.profile);case _UserActionSuccess() when actionSuccess != null:
return actionSuccess(_that.profile,_that.message);case _UserAccountDeleted() when accountDeleted != null:
return accountDeleted(_that.message);case _UserError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( UserProfile profile)  loaded,required TResult Function( UserProfile? profile)  actionInProgress,required TResult Function( UserProfile? profile,  String message)  actionSuccess,required TResult Function( String message)  accountDeleted,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _UserInitial():
return initial();case _UserLoading():
return loading();case _UserLoaded():
return loaded(_that.profile);case _UserActionInProgress():
return actionInProgress(_that.profile);case _UserActionSuccess():
return actionSuccess(_that.profile,_that.message);case _UserAccountDeleted():
return accountDeleted(_that.message);case _UserError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( UserProfile profile)?  loaded,TResult? Function( UserProfile? profile)?  actionInProgress,TResult? Function( UserProfile? profile,  String message)?  actionSuccess,TResult? Function( String message)?  accountDeleted,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _UserInitial() when initial != null:
return initial();case _UserLoading() when loading != null:
return loading();case _UserLoaded() when loaded != null:
return loaded(_that.profile);case _UserActionInProgress() when actionInProgress != null:
return actionInProgress(_that.profile);case _UserActionSuccess() when actionSuccess != null:
return actionSuccess(_that.profile,_that.message);case _UserAccountDeleted() when accountDeleted != null:
return accountDeleted(_that.message);case _UserError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _UserInitial implements UserState {
  const _UserInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserState.initial()';
}


}




/// @nodoc


class _UserLoading implements UserState {
  const _UserLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserState.loading()';
}


}




/// @nodoc


class _UserLoaded implements UserState {
  const _UserLoaded(this.profile);
  

 final  UserProfile profile;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserLoadedCopyWith<_UserLoaded> get copyWith => __$UserLoadedCopyWithImpl<_UserLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserLoaded&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'UserState.loaded(profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$UserLoadedCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserLoadedCopyWith(_UserLoaded value, $Res Function(_UserLoaded) _then) = __$UserLoadedCopyWithImpl;
@useResult
$Res call({
 UserProfile profile
});


$UserProfileCopyWith<$Res> get profile;

}
/// @nodoc
class __$UserLoadedCopyWithImpl<$Res>
    implements _$UserLoadedCopyWith<$Res> {
  __$UserLoadedCopyWithImpl(this._self, this._then);

  final _UserLoaded _self;
  final $Res Function(_UserLoaded) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(_UserLoaded(
null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile,
  ));
}

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res> get profile {
  
  return $UserProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

/// @nodoc


class _UserActionInProgress implements UserState {
  const _UserActionInProgress(this.profile);
  

 final  UserProfile? profile;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserActionInProgressCopyWith<_UserActionInProgress> get copyWith => __$UserActionInProgressCopyWithImpl<_UserActionInProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserActionInProgress&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'UserState.actionInProgress(profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$UserActionInProgressCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserActionInProgressCopyWith(_UserActionInProgress value, $Res Function(_UserActionInProgress) _then) = __$UserActionInProgressCopyWithImpl;
@useResult
$Res call({
 UserProfile? profile
});


$UserProfileCopyWith<$Res>? get profile;

}
/// @nodoc
class __$UserActionInProgressCopyWithImpl<$Res>
    implements _$UserActionInProgressCopyWith<$Res> {
  __$UserActionInProgressCopyWithImpl(this._self, this._then);

  final _UserActionInProgress _self;
  final $Res Function(_UserActionInProgress) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = freezed,}) {
  return _then(_UserActionInProgress(
freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,
  ));
}

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $UserProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

/// @nodoc


class _UserActionSuccess implements UserState {
  const _UserActionSuccess({this.profile, required this.message});
  

 final  UserProfile? profile;
 final  String message;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserActionSuccessCopyWith<_UserActionSuccess> get copyWith => __$UserActionSuccessCopyWithImpl<_UserActionSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserActionSuccess&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,profile,message);

@override
String toString() {
  return 'UserState.actionSuccess(profile: $profile, message: $message)';
}


}

/// @nodoc
abstract mixin class _$UserActionSuccessCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserActionSuccessCopyWith(_UserActionSuccess value, $Res Function(_UserActionSuccess) _then) = __$UserActionSuccessCopyWithImpl;
@useResult
$Res call({
 UserProfile? profile, String message
});


$UserProfileCopyWith<$Res>? get profile;

}
/// @nodoc
class __$UserActionSuccessCopyWithImpl<$Res>
    implements _$UserActionSuccessCopyWith<$Res> {
  __$UserActionSuccessCopyWithImpl(this._self, this._then);

  final _UserActionSuccess _self;
  final $Res Function(_UserActionSuccess) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = freezed,Object? message = null,}) {
  return _then(_UserActionSuccess(
profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $UserProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

/// @nodoc


class _UserAccountDeleted implements UserState {
  const _UserAccountDeleted(this.message);
  

 final  String message;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAccountDeletedCopyWith<_UserAccountDeleted> get copyWith => __$UserAccountDeletedCopyWithImpl<_UserAccountDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAccountDeleted&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'UserState.accountDeleted(message: $message)';
}


}

/// @nodoc
abstract mixin class _$UserAccountDeletedCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserAccountDeletedCopyWith(_UserAccountDeleted value, $Res Function(_UserAccountDeleted) _then) = __$UserAccountDeletedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$UserAccountDeletedCopyWithImpl<$Res>
    implements _$UserAccountDeletedCopyWith<$Res> {
  __$UserAccountDeletedCopyWithImpl(this._self, this._then);

  final _UserAccountDeleted _self;
  final $Res Function(_UserAccountDeleted) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_UserAccountDeleted(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UserError implements UserState {
  const _UserError(this.message);
  

 final  String message;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserErrorCopyWith<_UserError> get copyWith => __$UserErrorCopyWithImpl<_UserError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'UserState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$UserErrorCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserErrorCopyWith(_UserError value, $Res Function(_UserError) _then) = __$UserErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$UserErrorCopyWithImpl<$Res>
    implements _$UserErrorCopyWith<$Res> {
  __$UserErrorCopyWithImpl(this._self, this._then);

  final _UserError _self;
  final $Res Function(_UserError) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_UserError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
