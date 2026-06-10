// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'questionnaire_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestionnaireResponse {

 String get phonePurpose; String get name; int get age; String get gender; int get sleepHours; int get academicPerformance; int get socialInteractionScore; int get physicalExerciseHours; int get sadnessFrequency; int get selfEsteemScore; int get dailyPhoneUsageHours; String get primaryGoal;
/// Create a copy of QuestionnaireResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionnaireResponseCopyWith<QuestionnaireResponse> get copyWith => _$QuestionnaireResponseCopyWithImpl<QuestionnaireResponse>(this as QuestionnaireResponse, _$identity);

  /// Serializes this QuestionnaireResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionnaireResponse&&(identical(other.phonePurpose, phonePurpose) || other.phonePurpose == phonePurpose)&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.sleepHours, sleepHours) || other.sleepHours == sleepHours)&&(identical(other.academicPerformance, academicPerformance) || other.academicPerformance == academicPerformance)&&(identical(other.socialInteractionScore, socialInteractionScore) || other.socialInteractionScore == socialInteractionScore)&&(identical(other.physicalExerciseHours, physicalExerciseHours) || other.physicalExerciseHours == physicalExerciseHours)&&(identical(other.sadnessFrequency, sadnessFrequency) || other.sadnessFrequency == sadnessFrequency)&&(identical(other.selfEsteemScore, selfEsteemScore) || other.selfEsteemScore == selfEsteemScore)&&(identical(other.dailyPhoneUsageHours, dailyPhoneUsageHours) || other.dailyPhoneUsageHours == dailyPhoneUsageHours)&&(identical(other.primaryGoal, primaryGoal) || other.primaryGoal == primaryGoal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phonePurpose,name,age,gender,sleepHours,academicPerformance,socialInteractionScore,physicalExerciseHours,sadnessFrequency,selfEsteemScore,dailyPhoneUsageHours,primaryGoal);

@override
String toString() {
  return 'QuestionnaireResponse(phonePurpose: $phonePurpose, name: $name, age: $age, gender: $gender, sleepHours: $sleepHours, academicPerformance: $academicPerformance, socialInteractionScore: $socialInteractionScore, physicalExerciseHours: $physicalExerciseHours, sadnessFrequency: $sadnessFrequency, selfEsteemScore: $selfEsteemScore, dailyPhoneUsageHours: $dailyPhoneUsageHours, primaryGoal: $primaryGoal)';
}


}

/// @nodoc
abstract mixin class $QuestionnaireResponseCopyWith<$Res>  {
  factory $QuestionnaireResponseCopyWith(QuestionnaireResponse value, $Res Function(QuestionnaireResponse) _then) = _$QuestionnaireResponseCopyWithImpl;
@useResult
$Res call({
 String phonePurpose, String name, int age, String gender, int sleepHours, int academicPerformance, int socialInteractionScore, int physicalExerciseHours, int sadnessFrequency, int selfEsteemScore, int dailyPhoneUsageHours, String primaryGoal
});




}
/// @nodoc
class _$QuestionnaireResponseCopyWithImpl<$Res>
    implements $QuestionnaireResponseCopyWith<$Res> {
  _$QuestionnaireResponseCopyWithImpl(this._self, this._then);

  final QuestionnaireResponse _self;
  final $Res Function(QuestionnaireResponse) _then;

/// Create a copy of QuestionnaireResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phonePurpose = null,Object? name = null,Object? age = null,Object? gender = null,Object? sleepHours = null,Object? academicPerformance = null,Object? socialInteractionScore = null,Object? physicalExerciseHours = null,Object? sadnessFrequency = null,Object? selfEsteemScore = null,Object? dailyPhoneUsageHours = null,Object? primaryGoal = null,}) {
  return _then(_self.copyWith(
phonePurpose: null == phonePurpose ? _self.phonePurpose : phonePurpose // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,sleepHours: null == sleepHours ? _self.sleepHours : sleepHours // ignore: cast_nullable_to_non_nullable
as int,academicPerformance: null == academicPerformance ? _self.academicPerformance : academicPerformance // ignore: cast_nullable_to_non_nullable
as int,socialInteractionScore: null == socialInteractionScore ? _self.socialInteractionScore : socialInteractionScore // ignore: cast_nullable_to_non_nullable
as int,physicalExerciseHours: null == physicalExerciseHours ? _self.physicalExerciseHours : physicalExerciseHours // ignore: cast_nullable_to_non_nullable
as int,sadnessFrequency: null == sadnessFrequency ? _self.sadnessFrequency : sadnessFrequency // ignore: cast_nullable_to_non_nullable
as int,selfEsteemScore: null == selfEsteemScore ? _self.selfEsteemScore : selfEsteemScore // ignore: cast_nullable_to_non_nullable
as int,dailyPhoneUsageHours: null == dailyPhoneUsageHours ? _self.dailyPhoneUsageHours : dailyPhoneUsageHours // ignore: cast_nullable_to_non_nullable
as int,primaryGoal: null == primaryGoal ? _self.primaryGoal : primaryGoal // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionnaireResponse].
extension QuestionnaireResponsePatterns on QuestionnaireResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionnaireResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionnaireResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionnaireResponse value)  $default,){
final _that = this;
switch (_that) {
case _QuestionnaireResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionnaireResponse value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionnaireResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phonePurpose,  String name,  int age,  String gender,  int sleepHours,  int academicPerformance,  int socialInteractionScore,  int physicalExerciseHours,  int sadnessFrequency,  int selfEsteemScore,  int dailyPhoneUsageHours,  String primaryGoal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionnaireResponse() when $default != null:
return $default(_that.phonePurpose,_that.name,_that.age,_that.gender,_that.sleepHours,_that.academicPerformance,_that.socialInteractionScore,_that.physicalExerciseHours,_that.sadnessFrequency,_that.selfEsteemScore,_that.dailyPhoneUsageHours,_that.primaryGoal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phonePurpose,  String name,  int age,  String gender,  int sleepHours,  int academicPerformance,  int socialInteractionScore,  int physicalExerciseHours,  int sadnessFrequency,  int selfEsteemScore,  int dailyPhoneUsageHours,  String primaryGoal)  $default,) {final _that = this;
switch (_that) {
case _QuestionnaireResponse():
return $default(_that.phonePurpose,_that.name,_that.age,_that.gender,_that.sleepHours,_that.academicPerformance,_that.socialInteractionScore,_that.physicalExerciseHours,_that.sadnessFrequency,_that.selfEsteemScore,_that.dailyPhoneUsageHours,_that.primaryGoal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phonePurpose,  String name,  int age,  String gender,  int sleepHours,  int academicPerformance,  int socialInteractionScore,  int physicalExerciseHours,  int sadnessFrequency,  int selfEsteemScore,  int dailyPhoneUsageHours,  String primaryGoal)?  $default,) {final _that = this;
switch (_that) {
case _QuestionnaireResponse() when $default != null:
return $default(_that.phonePurpose,_that.name,_that.age,_that.gender,_that.sleepHours,_that.academicPerformance,_that.socialInteractionScore,_that.physicalExerciseHours,_that.sadnessFrequency,_that.selfEsteemScore,_that.dailyPhoneUsageHours,_that.primaryGoal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionnaireResponse extends QuestionnaireResponse {
  const _QuestionnaireResponse({this.phonePurpose = '', this.name = '', this.age = 21, this.gender = '', this.sleepHours = 8, this.academicPerformance = 50, this.socialInteractionScore = 5, this.physicalExerciseHours = 2, this.sadnessFrequency = 5, this.selfEsteemScore = 5, this.dailyPhoneUsageHours = 4, this.primaryGoal = 'Focus'}): super._();
  factory _QuestionnaireResponse.fromJson(Map<String, dynamic> json) => _$QuestionnaireResponseFromJson(json);

@override@JsonKey() final  String phonePurpose;
@override@JsonKey() final  String name;
@override@JsonKey() final  int age;
@override@JsonKey() final  String gender;
@override@JsonKey() final  int sleepHours;
@override@JsonKey() final  int academicPerformance;
@override@JsonKey() final  int socialInteractionScore;
@override@JsonKey() final  int physicalExerciseHours;
@override@JsonKey() final  int sadnessFrequency;
@override@JsonKey() final  int selfEsteemScore;
@override@JsonKey() final  int dailyPhoneUsageHours;
@override@JsonKey() final  String primaryGoal;

/// Create a copy of QuestionnaireResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionnaireResponseCopyWith<_QuestionnaireResponse> get copyWith => __$QuestionnaireResponseCopyWithImpl<_QuestionnaireResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionnaireResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionnaireResponse&&(identical(other.phonePurpose, phonePurpose) || other.phonePurpose == phonePurpose)&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.sleepHours, sleepHours) || other.sleepHours == sleepHours)&&(identical(other.academicPerformance, academicPerformance) || other.academicPerformance == academicPerformance)&&(identical(other.socialInteractionScore, socialInteractionScore) || other.socialInteractionScore == socialInteractionScore)&&(identical(other.physicalExerciseHours, physicalExerciseHours) || other.physicalExerciseHours == physicalExerciseHours)&&(identical(other.sadnessFrequency, sadnessFrequency) || other.sadnessFrequency == sadnessFrequency)&&(identical(other.selfEsteemScore, selfEsteemScore) || other.selfEsteemScore == selfEsteemScore)&&(identical(other.dailyPhoneUsageHours, dailyPhoneUsageHours) || other.dailyPhoneUsageHours == dailyPhoneUsageHours)&&(identical(other.primaryGoal, primaryGoal) || other.primaryGoal == primaryGoal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phonePurpose,name,age,gender,sleepHours,academicPerformance,socialInteractionScore,physicalExerciseHours,sadnessFrequency,selfEsteemScore,dailyPhoneUsageHours,primaryGoal);

@override
String toString() {
  return 'QuestionnaireResponse(phonePurpose: $phonePurpose, name: $name, age: $age, gender: $gender, sleepHours: $sleepHours, academicPerformance: $academicPerformance, socialInteractionScore: $socialInteractionScore, physicalExerciseHours: $physicalExerciseHours, sadnessFrequency: $sadnessFrequency, selfEsteemScore: $selfEsteemScore, dailyPhoneUsageHours: $dailyPhoneUsageHours, primaryGoal: $primaryGoal)';
}


}

/// @nodoc
abstract mixin class _$QuestionnaireResponseCopyWith<$Res> implements $QuestionnaireResponseCopyWith<$Res> {
  factory _$QuestionnaireResponseCopyWith(_QuestionnaireResponse value, $Res Function(_QuestionnaireResponse) _then) = __$QuestionnaireResponseCopyWithImpl;
@override @useResult
$Res call({
 String phonePurpose, String name, int age, String gender, int sleepHours, int academicPerformance, int socialInteractionScore, int physicalExerciseHours, int sadnessFrequency, int selfEsteemScore, int dailyPhoneUsageHours, String primaryGoal
});




}
/// @nodoc
class __$QuestionnaireResponseCopyWithImpl<$Res>
    implements _$QuestionnaireResponseCopyWith<$Res> {
  __$QuestionnaireResponseCopyWithImpl(this._self, this._then);

  final _QuestionnaireResponse _self;
  final $Res Function(_QuestionnaireResponse) _then;

/// Create a copy of QuestionnaireResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phonePurpose = null,Object? name = null,Object? age = null,Object? gender = null,Object? sleepHours = null,Object? academicPerformance = null,Object? socialInteractionScore = null,Object? physicalExerciseHours = null,Object? sadnessFrequency = null,Object? selfEsteemScore = null,Object? dailyPhoneUsageHours = null,Object? primaryGoal = null,}) {
  return _then(_QuestionnaireResponse(
phonePurpose: null == phonePurpose ? _self.phonePurpose : phonePurpose // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,sleepHours: null == sleepHours ? _self.sleepHours : sleepHours // ignore: cast_nullable_to_non_nullable
as int,academicPerformance: null == academicPerformance ? _self.academicPerformance : academicPerformance // ignore: cast_nullable_to_non_nullable
as int,socialInteractionScore: null == socialInteractionScore ? _self.socialInteractionScore : socialInteractionScore // ignore: cast_nullable_to_non_nullable
as int,physicalExerciseHours: null == physicalExerciseHours ? _self.physicalExerciseHours : physicalExerciseHours // ignore: cast_nullable_to_non_nullable
as int,sadnessFrequency: null == sadnessFrequency ? _self.sadnessFrequency : sadnessFrequency // ignore: cast_nullable_to_non_nullable
as int,selfEsteemScore: null == selfEsteemScore ? _self.selfEsteemScore : selfEsteemScore // ignore: cast_nullable_to_non_nullable
as int,dailyPhoneUsageHours: null == dailyPhoneUsageHours ? _self.dailyPhoneUsageHours : dailyPhoneUsageHours // ignore: cast_nullable_to_non_nullable
as int,primaryGoal: null == primaryGoal ? _self.primaryGoal : primaryGoal // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
