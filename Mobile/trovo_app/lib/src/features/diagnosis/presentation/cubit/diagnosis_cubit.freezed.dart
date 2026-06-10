// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnosis_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiagnosisState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagnosisState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiagnosisState()';
}


}

/// @nodoc
class $DiagnosisStateCopyWith<$Res>  {
$DiagnosisStateCopyWith(DiagnosisState _, $Res Function(DiagnosisState) __);
}


/// Adds pattern-matching-related methods to [DiagnosisState].
extension DiagnosisStatePatterns on DiagnosisState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _DiagnosisInitial value)?  initial,TResult Function( _DiagnosisLoading value)?  loading,TResult Function( _DiagnosisGenerated value)?  generated,TResult Function( _DiagnosisHistory value)?  history,TResult Function( _DiagnosisError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiagnosisInitial() when initial != null:
return initial(_that);case _DiagnosisLoading() when loading != null:
return loading(_that);case _DiagnosisGenerated() when generated != null:
return generated(_that);case _DiagnosisHistory() when history != null:
return history(_that);case _DiagnosisError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _DiagnosisInitial value)  initial,required TResult Function( _DiagnosisLoading value)  loading,required TResult Function( _DiagnosisGenerated value)  generated,required TResult Function( _DiagnosisHistory value)  history,required TResult Function( _DiagnosisError value)  error,}){
final _that = this;
switch (_that) {
case _DiagnosisInitial():
return initial(_that);case _DiagnosisLoading():
return loading(_that);case _DiagnosisGenerated():
return generated(_that);case _DiagnosisHistory():
return history(_that);case _DiagnosisError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _DiagnosisInitial value)?  initial,TResult? Function( _DiagnosisLoading value)?  loading,TResult? Function( _DiagnosisGenerated value)?  generated,TResult? Function( _DiagnosisHistory value)?  history,TResult? Function( _DiagnosisError value)?  error,}){
final _that = this;
switch (_that) {
case _DiagnosisInitial() when initial != null:
return initial(_that);case _DiagnosisLoading() when loading != null:
return loading(_that);case _DiagnosisGenerated() when generated != null:
return generated(_that);case _DiagnosisHistory() when history != null:
return history(_that);case _DiagnosisError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( DiagnosisResponse data)?  generated,TResult Function( DiagnosisResponse data)?  history,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiagnosisInitial() when initial != null:
return initial();case _DiagnosisLoading() when loading != null:
return loading();case _DiagnosisGenerated() when generated != null:
return generated(_that.data);case _DiagnosisHistory() when history != null:
return history(_that.data);case _DiagnosisError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( DiagnosisResponse data)  generated,required TResult Function( DiagnosisResponse data)  history,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _DiagnosisInitial():
return initial();case _DiagnosisLoading():
return loading();case _DiagnosisGenerated():
return generated(_that.data);case _DiagnosisHistory():
return history(_that.data);case _DiagnosisError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( DiagnosisResponse data)?  generated,TResult? Function( DiagnosisResponse data)?  history,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _DiagnosisInitial() when initial != null:
return initial();case _DiagnosisLoading() when loading != null:
return loading();case _DiagnosisGenerated() when generated != null:
return generated(_that.data);case _DiagnosisHistory() when history != null:
return history(_that.data);case _DiagnosisError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _DiagnosisInitial implements DiagnosisState {
  const _DiagnosisInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagnosisInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiagnosisState.initial()';
}


}




/// @nodoc


class _DiagnosisLoading implements DiagnosisState {
  const _DiagnosisLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagnosisLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiagnosisState.loading()';
}


}




/// @nodoc


class _DiagnosisGenerated implements DiagnosisState {
  const _DiagnosisGenerated(this.data);
  

 final  DiagnosisResponse data;

/// Create a copy of DiagnosisState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiagnosisGeneratedCopyWith<_DiagnosisGenerated> get copyWith => __$DiagnosisGeneratedCopyWithImpl<_DiagnosisGenerated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagnosisGenerated&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'DiagnosisState.generated(data: $data)';
}


}

/// @nodoc
abstract mixin class _$DiagnosisGeneratedCopyWith<$Res> implements $DiagnosisStateCopyWith<$Res> {
  factory _$DiagnosisGeneratedCopyWith(_DiagnosisGenerated value, $Res Function(_DiagnosisGenerated) _then) = __$DiagnosisGeneratedCopyWithImpl;
@useResult
$Res call({
 DiagnosisResponse data
});


$DiagnosisResponseCopyWith<$Res> get data;

}
/// @nodoc
class __$DiagnosisGeneratedCopyWithImpl<$Res>
    implements _$DiagnosisGeneratedCopyWith<$Res> {
  __$DiagnosisGeneratedCopyWithImpl(this._self, this._then);

  final _DiagnosisGenerated _self;
  final $Res Function(_DiagnosisGenerated) _then;

/// Create a copy of DiagnosisState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_DiagnosisGenerated(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DiagnosisResponse,
  ));
}

/// Create a copy of DiagnosisState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagnosisResponseCopyWith<$Res> get data {
  
  return $DiagnosisResponseCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _DiagnosisHistory implements DiagnosisState {
  const _DiagnosisHistory(this.data);
  

 final  DiagnosisResponse data;

/// Create a copy of DiagnosisState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiagnosisHistoryCopyWith<_DiagnosisHistory> get copyWith => __$DiagnosisHistoryCopyWithImpl<_DiagnosisHistory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagnosisHistory&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'DiagnosisState.history(data: $data)';
}


}

/// @nodoc
abstract mixin class _$DiagnosisHistoryCopyWith<$Res> implements $DiagnosisStateCopyWith<$Res> {
  factory _$DiagnosisHistoryCopyWith(_DiagnosisHistory value, $Res Function(_DiagnosisHistory) _then) = __$DiagnosisHistoryCopyWithImpl;
@useResult
$Res call({
 DiagnosisResponse data
});


$DiagnosisResponseCopyWith<$Res> get data;

}
/// @nodoc
class __$DiagnosisHistoryCopyWithImpl<$Res>
    implements _$DiagnosisHistoryCopyWith<$Res> {
  __$DiagnosisHistoryCopyWithImpl(this._self, this._then);

  final _DiagnosisHistory _self;
  final $Res Function(_DiagnosisHistory) _then;

/// Create a copy of DiagnosisState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_DiagnosisHistory(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DiagnosisResponse,
  ));
}

/// Create a copy of DiagnosisState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagnosisResponseCopyWith<$Res> get data {
  
  return $DiagnosisResponseCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _DiagnosisError implements DiagnosisState {
  const _DiagnosisError(this.message);
  

 final  String message;

/// Create a copy of DiagnosisState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiagnosisErrorCopyWith<_DiagnosisError> get copyWith => __$DiagnosisErrorCopyWithImpl<_DiagnosisError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagnosisError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DiagnosisState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$DiagnosisErrorCopyWith<$Res> implements $DiagnosisStateCopyWith<$Res> {
  factory _$DiagnosisErrorCopyWith(_DiagnosisError value, $Res Function(_DiagnosisError) _then) = __$DiagnosisErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$DiagnosisErrorCopyWithImpl<$Res>
    implements _$DiagnosisErrorCopyWith<$Res> {
  __$DiagnosisErrorCopyWithImpl(this._self, this._then);

  final _DiagnosisError _self;
  final $Res Function(_DiagnosisError) _then;

/// Create a copy of DiagnosisState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_DiagnosisError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
