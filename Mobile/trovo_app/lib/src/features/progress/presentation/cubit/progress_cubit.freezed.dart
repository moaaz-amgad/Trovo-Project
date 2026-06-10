// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProgressState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProgressState()';
}


}

/// @nodoc
class $ProgressStateCopyWith<$Res>  {
$ProgressStateCopyWith(ProgressState _, $Res Function(ProgressState) __);
}


/// Adds pattern-matching-related methods to [ProgressState].
extension ProgressStatePatterns on ProgressState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ProgressInitial value)?  initial,TResult Function( _ProgressLoading value)?  loading,TResult Function( _ProgressLoaded value)?  loaded,TResult Function( _ProgressError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgressInitial() when initial != null:
return initial(_that);case _ProgressLoading() when loading != null:
return loading(_that);case _ProgressLoaded() when loaded != null:
return loaded(_that);case _ProgressError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ProgressInitial value)  initial,required TResult Function( _ProgressLoading value)  loading,required TResult Function( _ProgressLoaded value)  loaded,required TResult Function( _ProgressError value)  error,}){
final _that = this;
switch (_that) {
case _ProgressInitial():
return initial(_that);case _ProgressLoading():
return loading(_that);case _ProgressLoaded():
return loaded(_that);case _ProgressError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ProgressInitial value)?  initial,TResult? Function( _ProgressLoading value)?  loading,TResult? Function( _ProgressLoaded value)?  loaded,TResult? Function( _ProgressError value)?  error,}){
final _that = this;
switch (_that) {
case _ProgressInitial() when initial != null:
return initial(_that);case _ProgressLoading() when loading != null:
return loading(_that);case _ProgressLoaded() when loaded != null:
return loaded(_that);case _ProgressError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ProgressSummary? summary,  List<ProgressEntry> history)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgressInitial() when initial != null:
return initial();case _ProgressLoading() when loading != null:
return loading();case _ProgressLoaded() when loaded != null:
return loaded(_that.summary,_that.history);case _ProgressError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ProgressSummary? summary,  List<ProgressEntry> history)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _ProgressInitial():
return initial();case _ProgressLoading():
return loading();case _ProgressLoaded():
return loaded(_that.summary,_that.history);case _ProgressError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ProgressSummary? summary,  List<ProgressEntry> history)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _ProgressInitial() when initial != null:
return initial();case _ProgressLoading() when loading != null:
return loading();case _ProgressLoaded() when loaded != null:
return loaded(_that.summary,_that.history);case _ProgressError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _ProgressInitial implements ProgressState {
  const _ProgressInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProgressState.initial()';
}


}




/// @nodoc


class _ProgressLoading implements ProgressState {
  const _ProgressLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProgressState.loading()';
}


}




/// @nodoc


class _ProgressLoaded implements ProgressState {
  const _ProgressLoaded({this.summary, final  List<ProgressEntry> history = const <ProgressEntry>[]}): _history = history;
  

 final  ProgressSummary? summary;
 final  List<ProgressEntry> _history;
@JsonKey() List<ProgressEntry> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of ProgressState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressLoadedCopyWith<_ProgressLoaded> get copyWith => __$ProgressLoadedCopyWithImpl<_ProgressLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressLoaded&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._history, _history));
}


@override
int get hashCode => Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(_history));

@override
String toString() {
  return 'ProgressState.loaded(summary: $summary, history: $history)';
}


}

/// @nodoc
abstract mixin class _$ProgressLoadedCopyWith<$Res> implements $ProgressStateCopyWith<$Res> {
  factory _$ProgressLoadedCopyWith(_ProgressLoaded value, $Res Function(_ProgressLoaded) _then) = __$ProgressLoadedCopyWithImpl;
@useResult
$Res call({
 ProgressSummary? summary, List<ProgressEntry> history
});


$ProgressSummaryCopyWith<$Res>? get summary;

}
/// @nodoc
class __$ProgressLoadedCopyWithImpl<$Res>
    implements _$ProgressLoadedCopyWith<$Res> {
  __$ProgressLoadedCopyWithImpl(this._self, this._then);

  final _ProgressLoaded _self;
  final $Res Function(_ProgressLoaded) _then;

/// Create a copy of ProgressState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? summary = freezed,Object? history = null,}) {
  return _then(_ProgressLoaded(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ProgressSummary?,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<ProgressEntry>,
  ));
}

/// Create a copy of ProgressState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgressSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $ProgressSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc


class _ProgressError implements ProgressState {
  const _ProgressError(this.message);
  

 final  String message;

/// Create a copy of ProgressState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressErrorCopyWith<_ProgressError> get copyWith => __$ProgressErrorCopyWithImpl<_ProgressError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ProgressState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ProgressErrorCopyWith<$Res> implements $ProgressStateCopyWith<$Res> {
  factory _$ProgressErrorCopyWith(_ProgressError value, $Res Function(_ProgressError) _then) = __$ProgressErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ProgressErrorCopyWithImpl<$Res>
    implements _$ProgressErrorCopyWith<$Res> {
  __$ProgressErrorCopyWithImpl(this._self, this._then);

  final _ProgressError _self;
  final $Res Function(_ProgressError) _then;

/// Create a copy of ProgressState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_ProgressError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
