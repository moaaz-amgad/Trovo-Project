// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mini_game_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MiniGameDashboardState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MiniGameDashboardState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MiniGameDashboardState()';
}


}

/// @nodoc
class $MiniGameDashboardStateCopyWith<$Res>  {
$MiniGameDashboardStateCopyWith(MiniGameDashboardState _, $Res Function(MiniGameDashboardState) __);
}


/// Adds pattern-matching-related methods to [MiniGameDashboardState].
extension MiniGameDashboardStatePatterns on MiniGameDashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _MiniGameInitial value)?  initial,TResult Function( _MiniGameLoading value)?  loading,TResult Function( _MiniGameLoaded value)?  loaded,TResult Function( _MiniGameError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MiniGameInitial() when initial != null:
return initial(_that);case _MiniGameLoading() when loading != null:
return loading(_that);case _MiniGameLoaded() when loaded != null:
return loaded(_that);case _MiniGameError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _MiniGameInitial value)  initial,required TResult Function( _MiniGameLoading value)  loading,required TResult Function( _MiniGameLoaded value)  loaded,required TResult Function( _MiniGameError value)  error,}){
final _that = this;
switch (_that) {
case _MiniGameInitial():
return initial(_that);case _MiniGameLoading():
return loading(_that);case _MiniGameLoaded():
return loaded(_that);case _MiniGameError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _MiniGameInitial value)?  initial,TResult? Function( _MiniGameLoading value)?  loading,TResult? Function( _MiniGameLoaded value)?  loaded,TResult? Function( _MiniGameError value)?  error,}){
final _that = this;
switch (_that) {
case _MiniGameInitial() when initial != null:
return initial(_that);case _MiniGameLoading() when loading != null:
return loading(_that);case _MiniGameLoaded() when loaded != null:
return loaded(_that);case _MiniGameError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( MiniGameDashboard? dashboard,  MiniGameStats? stats,  List<MiniGameRecord> history)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MiniGameInitial() when initial != null:
return initial();case _MiniGameLoading() when loading != null:
return loading();case _MiniGameLoaded() when loaded != null:
return loaded(_that.dashboard,_that.stats,_that.history);case _MiniGameError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( MiniGameDashboard? dashboard,  MiniGameStats? stats,  List<MiniGameRecord> history)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _MiniGameInitial():
return initial();case _MiniGameLoading():
return loading();case _MiniGameLoaded():
return loaded(_that.dashboard,_that.stats,_that.history);case _MiniGameError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( MiniGameDashboard? dashboard,  MiniGameStats? stats,  List<MiniGameRecord> history)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _MiniGameInitial() when initial != null:
return initial();case _MiniGameLoading() when loading != null:
return loading();case _MiniGameLoaded() when loaded != null:
return loaded(_that.dashboard,_that.stats,_that.history);case _MiniGameError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _MiniGameInitial implements MiniGameDashboardState {
  const _MiniGameInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MiniGameInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MiniGameDashboardState.initial()';
}


}




/// @nodoc


class _MiniGameLoading implements MiniGameDashboardState {
  const _MiniGameLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MiniGameLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MiniGameDashboardState.loading()';
}


}




/// @nodoc


class _MiniGameLoaded implements MiniGameDashboardState {
  const _MiniGameLoaded({this.dashboard, this.stats, final  List<MiniGameRecord> history = const <MiniGameRecord>[]}): _history = history;
  

 final  MiniGameDashboard? dashboard;
 final  MiniGameStats? stats;
 final  List<MiniGameRecord> _history;
@JsonKey() List<MiniGameRecord> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of MiniGameDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MiniGameLoadedCopyWith<_MiniGameLoaded> get copyWith => __$MiniGameLoadedCopyWithImpl<_MiniGameLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MiniGameLoaded&&(identical(other.dashboard, dashboard) || other.dashboard == dashboard)&&(identical(other.stats, stats) || other.stats == stats)&&const DeepCollectionEquality().equals(other._history, _history));
}


@override
int get hashCode => Object.hash(runtimeType,dashboard,stats,const DeepCollectionEquality().hash(_history));

@override
String toString() {
  return 'MiniGameDashboardState.loaded(dashboard: $dashboard, stats: $stats, history: $history)';
}


}

/// @nodoc
abstract mixin class _$MiniGameLoadedCopyWith<$Res> implements $MiniGameDashboardStateCopyWith<$Res> {
  factory _$MiniGameLoadedCopyWith(_MiniGameLoaded value, $Res Function(_MiniGameLoaded) _then) = __$MiniGameLoadedCopyWithImpl;
@useResult
$Res call({
 MiniGameDashboard? dashboard, MiniGameStats? stats, List<MiniGameRecord> history
});


$MiniGameStatsCopyWith<$Res>? get stats;

}
/// @nodoc
class __$MiniGameLoadedCopyWithImpl<$Res>
    implements _$MiniGameLoadedCopyWith<$Res> {
  __$MiniGameLoadedCopyWithImpl(this._self, this._then);

  final _MiniGameLoaded _self;
  final $Res Function(_MiniGameLoaded) _then;

/// Create a copy of MiniGameDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? dashboard = freezed,Object? stats = freezed,Object? history = null,}) {
  return _then(_MiniGameLoaded(
dashboard: freezed == dashboard ? _self.dashboard : dashboard // ignore: cast_nullable_to_non_nullable
as MiniGameDashboard?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as MiniGameStats?,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<MiniGameRecord>,
  ));
}

/// Create a copy of MiniGameDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MiniGameStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $MiniGameStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}

/// @nodoc


class _MiniGameError implements MiniGameDashboardState {
  const _MiniGameError(this.message);
  

 final  String message;

/// Create a copy of MiniGameDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MiniGameErrorCopyWith<_MiniGameError> get copyWith => __$MiniGameErrorCopyWithImpl<_MiniGameError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MiniGameError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MiniGameDashboardState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$MiniGameErrorCopyWith<$Res> implements $MiniGameDashboardStateCopyWith<$Res> {
  factory _$MiniGameErrorCopyWith(_MiniGameError value, $Res Function(_MiniGameError) _then) = __$MiniGameErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$MiniGameErrorCopyWithImpl<$Res>
    implements _$MiniGameErrorCopyWith<$Res> {
  __$MiniGameErrorCopyWithImpl(this._self, this._then);

  final _MiniGameError _self;
  final $Res Function(_MiniGameError) _then;

/// Create a copy of MiniGameDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_MiniGameError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
