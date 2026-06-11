// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_usage_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhoneUsageData {

@JsonKey(name: 'usage_id') int get usageId;@JsonKey(name: 'user_id') int get userId;@JsonKey(name: 'diagnosis_id') int get diagnosisId;@JsonKey(name: 'daily_usage_hours') double get dailyUsageHours;@JsonKey(name: 'screen_time_before_bed') double get screenTimeBeforeBed;@JsonKey(name: 'phone_check_per_day') int get phoneCheckPerDay;@JsonKey(name: 'apps_used_daily') int get appsUsedDaily;@JsonKey(name: 'time_on_social_media') double get timeOnSocialMedia;@JsonKey(name: 'time_in_gaming') double get timeInGaming;@JsonKey(name: 'weekend_usage_hours') double get weekendUsageHours;@JsonKey(name: 'collected_at') DateTime? get collectedAt;
/// Create a copy of PhoneUsageData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneUsageDataCopyWith<PhoneUsageData> get copyWith => _$PhoneUsageDataCopyWithImpl<PhoneUsageData>(this as PhoneUsageData, _$identity);

  /// Serializes this PhoneUsageData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneUsageData&&(identical(other.usageId, usageId) || other.usageId == usageId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.diagnosisId, diagnosisId) || other.diagnosisId == diagnosisId)&&(identical(other.dailyUsageHours, dailyUsageHours) || other.dailyUsageHours == dailyUsageHours)&&(identical(other.screenTimeBeforeBed, screenTimeBeforeBed) || other.screenTimeBeforeBed == screenTimeBeforeBed)&&(identical(other.phoneCheckPerDay, phoneCheckPerDay) || other.phoneCheckPerDay == phoneCheckPerDay)&&(identical(other.appsUsedDaily, appsUsedDaily) || other.appsUsedDaily == appsUsedDaily)&&(identical(other.timeOnSocialMedia, timeOnSocialMedia) || other.timeOnSocialMedia == timeOnSocialMedia)&&(identical(other.timeInGaming, timeInGaming) || other.timeInGaming == timeInGaming)&&(identical(other.weekendUsageHours, weekendUsageHours) || other.weekendUsageHours == weekendUsageHours)&&(identical(other.collectedAt, collectedAt) || other.collectedAt == collectedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,usageId,userId,diagnosisId,dailyUsageHours,screenTimeBeforeBed,phoneCheckPerDay,appsUsedDaily,timeOnSocialMedia,timeInGaming,weekendUsageHours,collectedAt);

@override
String toString() {
  return 'PhoneUsageData(usageId: $usageId, userId: $userId, diagnosisId: $diagnosisId, dailyUsageHours: $dailyUsageHours, screenTimeBeforeBed: $screenTimeBeforeBed, phoneCheckPerDay: $phoneCheckPerDay, appsUsedDaily: $appsUsedDaily, timeOnSocialMedia: $timeOnSocialMedia, timeInGaming: $timeInGaming, weekendUsageHours: $weekendUsageHours, collectedAt: $collectedAt)';
}


}

/// @nodoc
abstract mixin class $PhoneUsageDataCopyWith<$Res>  {
  factory $PhoneUsageDataCopyWith(PhoneUsageData value, $Res Function(PhoneUsageData) _then) = _$PhoneUsageDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'usage_id') int usageId,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'diagnosis_id') int diagnosisId,@JsonKey(name: 'daily_usage_hours') double dailyUsageHours,@JsonKey(name: 'screen_time_before_bed') double screenTimeBeforeBed,@JsonKey(name: 'phone_check_per_day') int phoneCheckPerDay,@JsonKey(name: 'apps_used_daily') int appsUsedDaily,@JsonKey(name: 'time_on_social_media') double timeOnSocialMedia,@JsonKey(name: 'time_in_gaming') double timeInGaming,@JsonKey(name: 'weekend_usage_hours') double weekendUsageHours,@JsonKey(name: 'collected_at') DateTime? collectedAt
});




}
/// @nodoc
class _$PhoneUsageDataCopyWithImpl<$Res>
    implements $PhoneUsageDataCopyWith<$Res> {
  _$PhoneUsageDataCopyWithImpl(this._self, this._then);

  final PhoneUsageData _self;
  final $Res Function(PhoneUsageData) _then;

/// Create a copy of PhoneUsageData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? usageId = null,Object? userId = null,Object? diagnosisId = null,Object? dailyUsageHours = null,Object? screenTimeBeforeBed = null,Object? phoneCheckPerDay = null,Object? appsUsedDaily = null,Object? timeOnSocialMedia = null,Object? timeInGaming = null,Object? weekendUsageHours = null,Object? collectedAt = freezed,}) {
  return _then(_self.copyWith(
usageId: null == usageId ? _self.usageId : usageId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,diagnosisId: null == diagnosisId ? _self.diagnosisId : diagnosisId // ignore: cast_nullable_to_non_nullable
as int,dailyUsageHours: null == dailyUsageHours ? _self.dailyUsageHours : dailyUsageHours // ignore: cast_nullable_to_non_nullable
as double,screenTimeBeforeBed: null == screenTimeBeforeBed ? _self.screenTimeBeforeBed : screenTimeBeforeBed // ignore: cast_nullable_to_non_nullable
as double,phoneCheckPerDay: null == phoneCheckPerDay ? _self.phoneCheckPerDay : phoneCheckPerDay // ignore: cast_nullable_to_non_nullable
as int,appsUsedDaily: null == appsUsedDaily ? _self.appsUsedDaily : appsUsedDaily // ignore: cast_nullable_to_non_nullable
as int,timeOnSocialMedia: null == timeOnSocialMedia ? _self.timeOnSocialMedia : timeOnSocialMedia // ignore: cast_nullable_to_non_nullable
as double,timeInGaming: null == timeInGaming ? _self.timeInGaming : timeInGaming // ignore: cast_nullable_to_non_nullable
as double,weekendUsageHours: null == weekendUsageHours ? _self.weekendUsageHours : weekendUsageHours // ignore: cast_nullable_to_non_nullable
as double,collectedAt: freezed == collectedAt ? _self.collectedAt : collectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneUsageData].
extension PhoneUsageDataPatterns on PhoneUsageData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneUsageData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneUsageData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneUsageData value)  $default,){
final _that = this;
switch (_that) {
case _PhoneUsageData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneUsageData value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneUsageData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'usage_id')  int usageId, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'diagnosis_id')  int diagnosisId, @JsonKey(name: 'daily_usage_hours')  double dailyUsageHours, @JsonKey(name: 'screen_time_before_bed')  double screenTimeBeforeBed, @JsonKey(name: 'phone_check_per_day')  int phoneCheckPerDay, @JsonKey(name: 'apps_used_daily')  int appsUsedDaily, @JsonKey(name: 'time_on_social_media')  double timeOnSocialMedia, @JsonKey(name: 'time_in_gaming')  double timeInGaming, @JsonKey(name: 'weekend_usage_hours')  double weekendUsageHours, @JsonKey(name: 'collected_at')  DateTime? collectedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneUsageData() when $default != null:
return $default(_that.usageId,_that.userId,_that.diagnosisId,_that.dailyUsageHours,_that.screenTimeBeforeBed,_that.phoneCheckPerDay,_that.appsUsedDaily,_that.timeOnSocialMedia,_that.timeInGaming,_that.weekendUsageHours,_that.collectedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'usage_id')  int usageId, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'diagnosis_id')  int diagnosisId, @JsonKey(name: 'daily_usage_hours')  double dailyUsageHours, @JsonKey(name: 'screen_time_before_bed')  double screenTimeBeforeBed, @JsonKey(name: 'phone_check_per_day')  int phoneCheckPerDay, @JsonKey(name: 'apps_used_daily')  int appsUsedDaily, @JsonKey(name: 'time_on_social_media')  double timeOnSocialMedia, @JsonKey(name: 'time_in_gaming')  double timeInGaming, @JsonKey(name: 'weekend_usage_hours')  double weekendUsageHours, @JsonKey(name: 'collected_at')  DateTime? collectedAt)  $default,) {final _that = this;
switch (_that) {
case _PhoneUsageData():
return $default(_that.usageId,_that.userId,_that.diagnosisId,_that.dailyUsageHours,_that.screenTimeBeforeBed,_that.phoneCheckPerDay,_that.appsUsedDaily,_that.timeOnSocialMedia,_that.timeInGaming,_that.weekendUsageHours,_that.collectedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'usage_id')  int usageId, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'diagnosis_id')  int diagnosisId, @JsonKey(name: 'daily_usage_hours')  double dailyUsageHours, @JsonKey(name: 'screen_time_before_bed')  double screenTimeBeforeBed, @JsonKey(name: 'phone_check_per_day')  int phoneCheckPerDay, @JsonKey(name: 'apps_used_daily')  int appsUsedDaily, @JsonKey(name: 'time_on_social_media')  double timeOnSocialMedia, @JsonKey(name: 'time_in_gaming')  double timeInGaming, @JsonKey(name: 'weekend_usage_hours')  double weekendUsageHours, @JsonKey(name: 'collected_at')  DateTime? collectedAt)?  $default,) {final _that = this;
switch (_that) {
case _PhoneUsageData() when $default != null:
return $default(_that.usageId,_that.userId,_that.diagnosisId,_that.dailyUsageHours,_that.screenTimeBeforeBed,_that.phoneCheckPerDay,_that.appsUsedDaily,_that.timeOnSocialMedia,_that.timeInGaming,_that.weekendUsageHours,_that.collectedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneUsageData extends PhoneUsageData {
  const _PhoneUsageData({@JsonKey(name: 'usage_id') this.usageId = 0, @JsonKey(name: 'user_id') this.userId = 0, @JsonKey(name: 'diagnosis_id') this.diagnosisId = 0, @JsonKey(name: 'daily_usage_hours') this.dailyUsageHours = 0.0, @JsonKey(name: 'screen_time_before_bed') this.screenTimeBeforeBed = 0.0, @JsonKey(name: 'phone_check_per_day') this.phoneCheckPerDay = 0, @JsonKey(name: 'apps_used_daily') this.appsUsedDaily = 0, @JsonKey(name: 'time_on_social_media') this.timeOnSocialMedia = 0.0, @JsonKey(name: 'time_in_gaming') this.timeInGaming = 0.0, @JsonKey(name: 'weekend_usage_hours') this.weekendUsageHours = 0.0, @JsonKey(name: 'collected_at') this.collectedAt}): super._();
  factory _PhoneUsageData.fromJson(Map<String, dynamic> json) => _$PhoneUsageDataFromJson(json);

@override@JsonKey(name: 'usage_id') final  int usageId;
@override@JsonKey(name: 'user_id') final  int userId;
@override@JsonKey(name: 'diagnosis_id') final  int diagnosisId;
@override@JsonKey(name: 'daily_usage_hours') final  double dailyUsageHours;
@override@JsonKey(name: 'screen_time_before_bed') final  double screenTimeBeforeBed;
@override@JsonKey(name: 'phone_check_per_day') final  int phoneCheckPerDay;
@override@JsonKey(name: 'apps_used_daily') final  int appsUsedDaily;
@override@JsonKey(name: 'time_on_social_media') final  double timeOnSocialMedia;
@override@JsonKey(name: 'time_in_gaming') final  double timeInGaming;
@override@JsonKey(name: 'weekend_usage_hours') final  double weekendUsageHours;
@override@JsonKey(name: 'collected_at') final  DateTime? collectedAt;

/// Create a copy of PhoneUsageData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneUsageDataCopyWith<_PhoneUsageData> get copyWith => __$PhoneUsageDataCopyWithImpl<_PhoneUsageData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhoneUsageDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneUsageData&&(identical(other.usageId, usageId) || other.usageId == usageId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.diagnosisId, diagnosisId) || other.diagnosisId == diagnosisId)&&(identical(other.dailyUsageHours, dailyUsageHours) || other.dailyUsageHours == dailyUsageHours)&&(identical(other.screenTimeBeforeBed, screenTimeBeforeBed) || other.screenTimeBeforeBed == screenTimeBeforeBed)&&(identical(other.phoneCheckPerDay, phoneCheckPerDay) || other.phoneCheckPerDay == phoneCheckPerDay)&&(identical(other.appsUsedDaily, appsUsedDaily) || other.appsUsedDaily == appsUsedDaily)&&(identical(other.timeOnSocialMedia, timeOnSocialMedia) || other.timeOnSocialMedia == timeOnSocialMedia)&&(identical(other.timeInGaming, timeInGaming) || other.timeInGaming == timeInGaming)&&(identical(other.weekendUsageHours, weekendUsageHours) || other.weekendUsageHours == weekendUsageHours)&&(identical(other.collectedAt, collectedAt) || other.collectedAt == collectedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,usageId,userId,diagnosisId,dailyUsageHours,screenTimeBeforeBed,phoneCheckPerDay,appsUsedDaily,timeOnSocialMedia,timeInGaming,weekendUsageHours,collectedAt);

@override
String toString() {
  return 'PhoneUsageData(usageId: $usageId, userId: $userId, diagnosisId: $diagnosisId, dailyUsageHours: $dailyUsageHours, screenTimeBeforeBed: $screenTimeBeforeBed, phoneCheckPerDay: $phoneCheckPerDay, appsUsedDaily: $appsUsedDaily, timeOnSocialMedia: $timeOnSocialMedia, timeInGaming: $timeInGaming, weekendUsageHours: $weekendUsageHours, collectedAt: $collectedAt)';
}


}

/// @nodoc
abstract mixin class _$PhoneUsageDataCopyWith<$Res> implements $PhoneUsageDataCopyWith<$Res> {
  factory _$PhoneUsageDataCopyWith(_PhoneUsageData value, $Res Function(_PhoneUsageData) _then) = __$PhoneUsageDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'usage_id') int usageId,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'diagnosis_id') int diagnosisId,@JsonKey(name: 'daily_usage_hours') double dailyUsageHours,@JsonKey(name: 'screen_time_before_bed') double screenTimeBeforeBed,@JsonKey(name: 'phone_check_per_day') int phoneCheckPerDay,@JsonKey(name: 'apps_used_daily') int appsUsedDaily,@JsonKey(name: 'time_on_social_media') double timeOnSocialMedia,@JsonKey(name: 'time_in_gaming') double timeInGaming,@JsonKey(name: 'weekend_usage_hours') double weekendUsageHours,@JsonKey(name: 'collected_at') DateTime? collectedAt
});




}
/// @nodoc
class __$PhoneUsageDataCopyWithImpl<$Res>
    implements _$PhoneUsageDataCopyWith<$Res> {
  __$PhoneUsageDataCopyWithImpl(this._self, this._then);

  final _PhoneUsageData _self;
  final $Res Function(_PhoneUsageData) _then;

/// Create a copy of PhoneUsageData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? usageId = null,Object? userId = null,Object? diagnosisId = null,Object? dailyUsageHours = null,Object? screenTimeBeforeBed = null,Object? phoneCheckPerDay = null,Object? appsUsedDaily = null,Object? timeOnSocialMedia = null,Object? timeInGaming = null,Object? weekendUsageHours = null,Object? collectedAt = freezed,}) {
  return _then(_PhoneUsageData(
usageId: null == usageId ? _self.usageId : usageId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,diagnosisId: null == diagnosisId ? _self.diagnosisId : diagnosisId // ignore: cast_nullable_to_non_nullable
as int,dailyUsageHours: null == dailyUsageHours ? _self.dailyUsageHours : dailyUsageHours // ignore: cast_nullable_to_non_nullable
as double,screenTimeBeforeBed: null == screenTimeBeforeBed ? _self.screenTimeBeforeBed : screenTimeBeforeBed // ignore: cast_nullable_to_non_nullable
as double,phoneCheckPerDay: null == phoneCheckPerDay ? _self.phoneCheckPerDay : phoneCheckPerDay // ignore: cast_nullable_to_non_nullable
as int,appsUsedDaily: null == appsUsedDaily ? _self.appsUsedDaily : appsUsedDaily // ignore: cast_nullable_to_non_nullable
as int,timeOnSocialMedia: null == timeOnSocialMedia ? _self.timeOnSocialMedia : timeOnSocialMedia // ignore: cast_nullable_to_non_nullable
as double,timeInGaming: null == timeInGaming ? _self.timeInGaming : timeInGaming // ignore: cast_nullable_to_non_nullable
as double,weekendUsageHours: null == weekendUsageHours ? _self.weekendUsageHours : weekendUsageHours // ignore: cast_nullable_to_non_nullable
as double,collectedAt: freezed == collectedAt ? _self.collectedAt : collectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
