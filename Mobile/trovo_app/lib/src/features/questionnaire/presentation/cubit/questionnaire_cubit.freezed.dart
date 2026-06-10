// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'questionnaire_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuestionnaireState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionnaireState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestionnaireState()';
}


}

/// @nodoc
class $QuestionnaireStateCopyWith<$Res>  {
$QuestionnaireStateCopyWith(QuestionnaireState _, $Res Function(QuestionnaireState) __);
}


/// Adds pattern-matching-related methods to [QuestionnaireState].
extension QuestionnaireStatePatterns on QuestionnaireState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _QuestionnaireInitial value)?  initial,TResult Function( _QuestionnaireLoadingDraft value)?  loadingDraft,TResult Function( _QuestionnaireDraftLoaded value)?  draftLoaded,TResult Function( _QuestionnaireSubmitting value)?  submitting,TResult Function( _QuestionnaireSubmitted value)?  submitted,TResult Function( _QuestionnaireError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionnaireInitial() when initial != null:
return initial(_that);case _QuestionnaireLoadingDraft() when loadingDraft != null:
return loadingDraft(_that);case _QuestionnaireDraftLoaded() when draftLoaded != null:
return draftLoaded(_that);case _QuestionnaireSubmitting() when submitting != null:
return submitting(_that);case _QuestionnaireSubmitted() when submitted != null:
return submitted(_that);case _QuestionnaireError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _QuestionnaireInitial value)  initial,required TResult Function( _QuestionnaireLoadingDraft value)  loadingDraft,required TResult Function( _QuestionnaireDraftLoaded value)  draftLoaded,required TResult Function( _QuestionnaireSubmitting value)  submitting,required TResult Function( _QuestionnaireSubmitted value)  submitted,required TResult Function( _QuestionnaireError value)  error,}){
final _that = this;
switch (_that) {
case _QuestionnaireInitial():
return initial(_that);case _QuestionnaireLoadingDraft():
return loadingDraft(_that);case _QuestionnaireDraftLoaded():
return draftLoaded(_that);case _QuestionnaireSubmitting():
return submitting(_that);case _QuestionnaireSubmitted():
return submitted(_that);case _QuestionnaireError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _QuestionnaireInitial value)?  initial,TResult? Function( _QuestionnaireLoadingDraft value)?  loadingDraft,TResult? Function( _QuestionnaireDraftLoaded value)?  draftLoaded,TResult? Function( _QuestionnaireSubmitting value)?  submitting,TResult? Function( _QuestionnaireSubmitted value)?  submitted,TResult? Function( _QuestionnaireError value)?  error,}){
final _that = this;
switch (_that) {
case _QuestionnaireInitial() when initial != null:
return initial(_that);case _QuestionnaireLoadingDraft() when loadingDraft != null:
return loadingDraft(_that);case _QuestionnaireDraftLoaded() when draftLoaded != null:
return draftLoaded(_that);case _QuestionnaireSubmitting() when submitting != null:
return submitting(_that);case _QuestionnaireSubmitted() when submitted != null:
return submitted(_that);case _QuestionnaireError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loadingDraft,TResult Function( QuestionnaireDraft? draft)?  draftLoaded,TResult Function()?  submitting,TResult Function()?  submitted,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionnaireInitial() when initial != null:
return initial();case _QuestionnaireLoadingDraft() when loadingDraft != null:
return loadingDraft();case _QuestionnaireDraftLoaded() when draftLoaded != null:
return draftLoaded(_that.draft);case _QuestionnaireSubmitting() when submitting != null:
return submitting();case _QuestionnaireSubmitted() when submitted != null:
return submitted();case _QuestionnaireError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loadingDraft,required TResult Function( QuestionnaireDraft? draft)  draftLoaded,required TResult Function()  submitting,required TResult Function()  submitted,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _QuestionnaireInitial():
return initial();case _QuestionnaireLoadingDraft():
return loadingDraft();case _QuestionnaireDraftLoaded():
return draftLoaded(_that.draft);case _QuestionnaireSubmitting():
return submitting();case _QuestionnaireSubmitted():
return submitted();case _QuestionnaireError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loadingDraft,TResult? Function( QuestionnaireDraft? draft)?  draftLoaded,TResult? Function()?  submitting,TResult? Function()?  submitted,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _QuestionnaireInitial() when initial != null:
return initial();case _QuestionnaireLoadingDraft() when loadingDraft != null:
return loadingDraft();case _QuestionnaireDraftLoaded() when draftLoaded != null:
return draftLoaded(_that.draft);case _QuestionnaireSubmitting() when submitting != null:
return submitting();case _QuestionnaireSubmitted() when submitted != null:
return submitted();case _QuestionnaireError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionnaireInitial implements QuestionnaireState {
  const _QuestionnaireInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionnaireInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestionnaireState.initial()';
}


}




/// @nodoc


class _QuestionnaireLoadingDraft implements QuestionnaireState {
  const _QuestionnaireLoadingDraft();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionnaireLoadingDraft);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestionnaireState.loadingDraft()';
}


}




/// @nodoc


class _QuestionnaireDraftLoaded implements QuestionnaireState {
  const _QuestionnaireDraftLoaded(this.draft);
  

 final  QuestionnaireDraft? draft;

/// Create a copy of QuestionnaireState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionnaireDraftLoadedCopyWith<_QuestionnaireDraftLoaded> get copyWith => __$QuestionnaireDraftLoadedCopyWithImpl<_QuestionnaireDraftLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionnaireDraftLoaded&&(identical(other.draft, draft) || other.draft == draft));
}


@override
int get hashCode => Object.hash(runtimeType,draft);

@override
String toString() {
  return 'QuestionnaireState.draftLoaded(draft: $draft)';
}


}

/// @nodoc
abstract mixin class _$QuestionnaireDraftLoadedCopyWith<$Res> implements $QuestionnaireStateCopyWith<$Res> {
  factory _$QuestionnaireDraftLoadedCopyWith(_QuestionnaireDraftLoaded value, $Res Function(_QuestionnaireDraftLoaded) _then) = __$QuestionnaireDraftLoadedCopyWithImpl;
@useResult
$Res call({
 QuestionnaireDraft? draft
});




}
/// @nodoc
class __$QuestionnaireDraftLoadedCopyWithImpl<$Res>
    implements _$QuestionnaireDraftLoadedCopyWith<$Res> {
  __$QuestionnaireDraftLoadedCopyWithImpl(this._self, this._then);

  final _QuestionnaireDraftLoaded _self;
  final $Res Function(_QuestionnaireDraftLoaded) _then;

/// Create a copy of QuestionnaireState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draft = freezed,}) {
  return _then(_QuestionnaireDraftLoaded(
freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as QuestionnaireDraft?,
  ));
}


}

/// @nodoc


class _QuestionnaireSubmitting implements QuestionnaireState {
  const _QuestionnaireSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionnaireSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestionnaireState.submitting()';
}


}




/// @nodoc


class _QuestionnaireSubmitted implements QuestionnaireState {
  const _QuestionnaireSubmitted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionnaireSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestionnaireState.submitted()';
}


}




/// @nodoc


class _QuestionnaireError implements QuestionnaireState {
  const _QuestionnaireError(this.message);
  

 final  String message;

/// Create a copy of QuestionnaireState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionnaireErrorCopyWith<_QuestionnaireError> get copyWith => __$QuestionnaireErrorCopyWithImpl<_QuestionnaireError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionnaireError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'QuestionnaireState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$QuestionnaireErrorCopyWith<$Res> implements $QuestionnaireStateCopyWith<$Res> {
  factory _$QuestionnaireErrorCopyWith(_QuestionnaireError value, $Res Function(_QuestionnaireError) _then) = __$QuestionnaireErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$QuestionnaireErrorCopyWithImpl<$Res>
    implements _$QuestionnaireErrorCopyWith<$Res> {
  __$QuestionnaireErrorCopyWithImpl(this._self, this._then);

  final _QuestionnaireError _self;
  final $Res Function(_QuestionnaireError) _then;

/// Create a copy of QuestionnaireState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_QuestionnaireError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
