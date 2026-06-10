// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_usage_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PhoneUsageState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneUsageState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PhoneUsageState()';
}


}

/// @nodoc
class $PhoneUsageStateCopyWith<$Res>  {
$PhoneUsageStateCopyWith(PhoneUsageState _, $Res Function(PhoneUsageState) __);
}


/// Adds pattern-matching-related methods to [PhoneUsageState].
extension PhoneUsageStatePatterns on PhoneUsageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _PhoneUsageInitial value)?  initial,TResult Function( _PhoneUsageLoading value)?  loading,TResult Function( _PhoneUsagePermissionRequired value)?  permissionRequired,TResult Function( _PhoneUsageMetricsLoaded value)?  metricsLoaded,TResult Function( _PhoneUsageSubmitted value)?  submitted,TResult Function( _PhoneUsageError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneUsageInitial() when initial != null:
return initial(_that);case _PhoneUsageLoading() when loading != null:
return loading(_that);case _PhoneUsagePermissionRequired() when permissionRequired != null:
return permissionRequired(_that);case _PhoneUsageMetricsLoaded() when metricsLoaded != null:
return metricsLoaded(_that);case _PhoneUsageSubmitted() when submitted != null:
return submitted(_that);case _PhoneUsageError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _PhoneUsageInitial value)  initial,required TResult Function( _PhoneUsageLoading value)  loading,required TResult Function( _PhoneUsagePermissionRequired value)  permissionRequired,required TResult Function( _PhoneUsageMetricsLoaded value)  metricsLoaded,required TResult Function( _PhoneUsageSubmitted value)  submitted,required TResult Function( _PhoneUsageError value)  error,}){
final _that = this;
switch (_that) {
case _PhoneUsageInitial():
return initial(_that);case _PhoneUsageLoading():
return loading(_that);case _PhoneUsagePermissionRequired():
return permissionRequired(_that);case _PhoneUsageMetricsLoaded():
return metricsLoaded(_that);case _PhoneUsageSubmitted():
return submitted(_that);case _PhoneUsageError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _PhoneUsageInitial value)?  initial,TResult? Function( _PhoneUsageLoading value)?  loading,TResult? Function( _PhoneUsagePermissionRequired value)?  permissionRequired,TResult? Function( _PhoneUsageMetricsLoaded value)?  metricsLoaded,TResult? Function( _PhoneUsageSubmitted value)?  submitted,TResult? Function( _PhoneUsageError value)?  error,}){
final _that = this;
switch (_that) {
case _PhoneUsageInitial() when initial != null:
return initial(_that);case _PhoneUsageLoading() when loading != null:
return loading(_that);case _PhoneUsagePermissionRequired() when permissionRequired != null:
return permissionRequired(_that);case _PhoneUsageMetricsLoaded() when metricsLoaded != null:
return metricsLoaded(_that);case _PhoneUsageSubmitted() when submitted != null:
return submitted(_that);case _PhoneUsageError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String message)?  permissionRequired,TResult Function( PhoneUsageMetrics metrics)?  metricsLoaded,TResult Function( Map<String, dynamic> data)?  submitted,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneUsageInitial() when initial != null:
return initial();case _PhoneUsageLoading() when loading != null:
return loading();case _PhoneUsagePermissionRequired() when permissionRequired != null:
return permissionRequired(_that.message);case _PhoneUsageMetricsLoaded() when metricsLoaded != null:
return metricsLoaded(_that.metrics);case _PhoneUsageSubmitted() when submitted != null:
return submitted(_that.data);case _PhoneUsageError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String message)  permissionRequired,required TResult Function( PhoneUsageMetrics metrics)  metricsLoaded,required TResult Function( Map<String, dynamic> data)  submitted,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _PhoneUsageInitial():
return initial();case _PhoneUsageLoading():
return loading();case _PhoneUsagePermissionRequired():
return permissionRequired(_that.message);case _PhoneUsageMetricsLoaded():
return metricsLoaded(_that.metrics);case _PhoneUsageSubmitted():
return submitted(_that.data);case _PhoneUsageError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String message)?  permissionRequired,TResult? Function( PhoneUsageMetrics metrics)?  metricsLoaded,TResult? Function( Map<String, dynamic> data)?  submitted,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _PhoneUsageInitial() when initial != null:
return initial();case _PhoneUsageLoading() when loading != null:
return loading();case _PhoneUsagePermissionRequired() when permissionRequired != null:
return permissionRequired(_that.message);case _PhoneUsageMetricsLoaded() when metricsLoaded != null:
return metricsLoaded(_that.metrics);case _PhoneUsageSubmitted() when submitted != null:
return submitted(_that.data);case _PhoneUsageError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _PhoneUsageInitial implements PhoneUsageState {
  const _PhoneUsageInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneUsageInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PhoneUsageState.initial()';
}


}




/// @nodoc


class _PhoneUsageLoading implements PhoneUsageState {
  const _PhoneUsageLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneUsageLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PhoneUsageState.loading()';
}


}




/// @nodoc


class _PhoneUsagePermissionRequired implements PhoneUsageState {
  const _PhoneUsagePermissionRequired(this.message);
  

 final  String message;

/// Create a copy of PhoneUsageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneUsagePermissionRequiredCopyWith<_PhoneUsagePermissionRequired> get copyWith => __$PhoneUsagePermissionRequiredCopyWithImpl<_PhoneUsagePermissionRequired>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneUsagePermissionRequired&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PhoneUsageState.permissionRequired(message: $message)';
}


}

/// @nodoc
abstract mixin class _$PhoneUsagePermissionRequiredCopyWith<$Res> implements $PhoneUsageStateCopyWith<$Res> {
  factory _$PhoneUsagePermissionRequiredCopyWith(_PhoneUsagePermissionRequired value, $Res Function(_PhoneUsagePermissionRequired) _then) = __$PhoneUsagePermissionRequiredCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$PhoneUsagePermissionRequiredCopyWithImpl<$Res>
    implements _$PhoneUsagePermissionRequiredCopyWith<$Res> {
  __$PhoneUsagePermissionRequiredCopyWithImpl(this._self, this._then);

  final _PhoneUsagePermissionRequired _self;
  final $Res Function(_PhoneUsagePermissionRequired) _then;

/// Create a copy of PhoneUsageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_PhoneUsagePermissionRequired(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PhoneUsageMetricsLoaded implements PhoneUsageState {
  const _PhoneUsageMetricsLoaded(this.metrics);
  

 final  PhoneUsageMetrics metrics;

/// Create a copy of PhoneUsageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneUsageMetricsLoadedCopyWith<_PhoneUsageMetricsLoaded> get copyWith => __$PhoneUsageMetricsLoadedCopyWithImpl<_PhoneUsageMetricsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneUsageMetricsLoaded&&(identical(other.metrics, metrics) || other.metrics == metrics));
}


@override
int get hashCode => Object.hash(runtimeType,metrics);

@override
String toString() {
  return 'PhoneUsageState.metricsLoaded(metrics: $metrics)';
}


}

/// @nodoc
abstract mixin class _$PhoneUsageMetricsLoadedCopyWith<$Res> implements $PhoneUsageStateCopyWith<$Res> {
  factory _$PhoneUsageMetricsLoadedCopyWith(_PhoneUsageMetricsLoaded value, $Res Function(_PhoneUsageMetricsLoaded) _then) = __$PhoneUsageMetricsLoadedCopyWithImpl;
@useResult
$Res call({
 PhoneUsageMetrics metrics
});


$PhoneUsageMetricsCopyWith<$Res> get metrics;

}
/// @nodoc
class __$PhoneUsageMetricsLoadedCopyWithImpl<$Res>
    implements _$PhoneUsageMetricsLoadedCopyWith<$Res> {
  __$PhoneUsageMetricsLoadedCopyWithImpl(this._self, this._then);

  final _PhoneUsageMetricsLoaded _self;
  final $Res Function(_PhoneUsageMetricsLoaded) _then;

/// Create a copy of PhoneUsageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? metrics = null,}) {
  return _then(_PhoneUsageMetricsLoaded(
null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as PhoneUsageMetrics,
  ));
}

/// Create a copy of PhoneUsageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhoneUsageMetricsCopyWith<$Res> get metrics {
  
  return $PhoneUsageMetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}

/// @nodoc


class _PhoneUsageSubmitted implements PhoneUsageState {
  const _PhoneUsageSubmitted(final  Map<String, dynamic> data): _data = data;
  

 final  Map<String, dynamic> _data;
 Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


/// Create a copy of PhoneUsageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneUsageSubmittedCopyWith<_PhoneUsageSubmitted> get copyWith => __$PhoneUsageSubmittedCopyWithImpl<_PhoneUsageSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneUsageSubmitted&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'PhoneUsageState.submitted(data: $data)';
}


}

/// @nodoc
abstract mixin class _$PhoneUsageSubmittedCopyWith<$Res> implements $PhoneUsageStateCopyWith<$Res> {
  factory _$PhoneUsageSubmittedCopyWith(_PhoneUsageSubmitted value, $Res Function(_PhoneUsageSubmitted) _then) = __$PhoneUsageSubmittedCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> data
});




}
/// @nodoc
class __$PhoneUsageSubmittedCopyWithImpl<$Res>
    implements _$PhoneUsageSubmittedCopyWith<$Res> {
  __$PhoneUsageSubmittedCopyWithImpl(this._self, this._then);

  final _PhoneUsageSubmitted _self;
  final $Res Function(_PhoneUsageSubmitted) _then;

/// Create a copy of PhoneUsageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_PhoneUsageSubmitted(
null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class _PhoneUsageError implements PhoneUsageState {
  const _PhoneUsageError(this.message);
  

 final  String message;

/// Create a copy of PhoneUsageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneUsageErrorCopyWith<_PhoneUsageError> get copyWith => __$PhoneUsageErrorCopyWithImpl<_PhoneUsageError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneUsageError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PhoneUsageState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$PhoneUsageErrorCopyWith<$Res> implements $PhoneUsageStateCopyWith<$Res> {
  factory _$PhoneUsageErrorCopyWith(_PhoneUsageError value, $Res Function(_PhoneUsageError) _then) = __$PhoneUsageErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$PhoneUsageErrorCopyWithImpl<$Res>
    implements _$PhoneUsageErrorCopyWith<$Res> {
  __$PhoneUsageErrorCopyWithImpl(this._self, this._then);

  final _PhoneUsageError _self;
  final $Res Function(_PhoneUsageError) _then;

/// Create a copy of PhoneUsageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_PhoneUsageError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
