// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_usage_metrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhoneUsageMetrics {

@JsonKey(name: 'daily_usage_hours') double get dailyUsageHours;@JsonKey(name: 'screen_time_before_bed') double get screenTimeBeforeBed;@JsonKey(name: 'phone_check_per_day') int get phoneCheckPerDay;@JsonKey(name: 'apps_used_daily') int get appsUsedDaily;@JsonKey(name: 'time_on_social_media') double get timeOnSocialMedia;@JsonKey(name: 'time_in_gaming') double get timeInGaming;@JsonKey(name: 'weekend_usage_hours') double get weekendUsageHours;@JsonKey(name: 'collected_at') DateTime? get collectedAt;
/// Create a copy of PhoneUsageMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneUsageMetricsCopyWith<PhoneUsageMetrics> get copyWith => _$PhoneUsageMetricsCopyWithImpl<PhoneUsageMetrics>(this as PhoneUsageMetrics, _$identity);

  /// Serializes this PhoneUsageMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneUsageMetrics&&(identical(other.dailyUsageHours, dailyUsageHours) || other.dailyUsageHours == dailyUsageHours)&&(identical(other.screenTimeBeforeBed, screenTimeBeforeBed) || other.screenTimeBeforeBed == screenTimeBeforeBed)&&(identical(other.phoneCheckPerDay, phoneCheckPerDay) || other.phoneCheckPerDay == phoneCheckPerDay)&&(identical(other.appsUsedDaily, appsUsedDaily) || other.appsUsedDaily == appsUsedDaily)&&(identical(other.timeOnSocialMedia, timeOnSocialMedia) || other.timeOnSocialMedia == timeOnSocialMedia)&&(identical(other.timeInGaming, timeInGaming) || other.timeInGaming == timeInGaming)&&(identical(other.weekendUsageHours, weekendUsageHours) || other.weekendUsageHours == weekendUsageHours)&&(identical(other.collectedAt, collectedAt) || other.collectedAt == collectedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dailyUsageHours,screenTimeBeforeBed,phoneCheckPerDay,appsUsedDaily,timeOnSocialMedia,timeInGaming,weekendUsageHours,collectedAt);

@override
String toString() {
  return 'PhoneUsageMetrics(dailyUsageHours: $dailyUsageHours, screenTimeBeforeBed: $screenTimeBeforeBed, phoneCheckPerDay: $phoneCheckPerDay, appsUsedDaily: $appsUsedDaily, timeOnSocialMedia: $timeOnSocialMedia, timeInGaming: $timeInGaming, weekendUsageHours: $weekendUsageHours, collectedAt: $collectedAt)';
}


}

/// @nodoc
abstract mixin class $PhoneUsageMetricsCopyWith<$Res>  {
  factory $PhoneUsageMetricsCopyWith(PhoneUsageMetrics value, $Res Function(PhoneUsageMetrics) _then) = _$PhoneUsageMetricsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'daily_usage_hours') double dailyUsageHours,@JsonKey(name: 'screen_time_before_bed') double screenTimeBeforeBed,@JsonKey(name: 'phone_check_per_day') int phoneCheckPerDay,@JsonKey(name: 'apps_used_daily') int appsUsedDaily,@JsonKey(name: 'time_on_social_media') double timeOnSocialMedia,@JsonKey(name: 'time_in_gaming') double timeInGaming,@JsonKey(name: 'weekend_usage_hours') double weekendUsageHours,@JsonKey(name: 'collected_at') DateTime? collectedAt
});




}
/// @nodoc
class _$PhoneUsageMetricsCopyWithImpl<$Res>
    implements $PhoneUsageMetricsCopyWith<$Res> {
  _$PhoneUsageMetricsCopyWithImpl(this._self, this._then);

  final PhoneUsageMetrics _self;
  final $Res Function(PhoneUsageMetrics) _then;

/// Create a copy of PhoneUsageMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dailyUsageHours = null,Object? screenTimeBeforeBed = null,Object? phoneCheckPerDay = null,Object? appsUsedDaily = null,Object? timeOnSocialMedia = null,Object? timeInGaming = null,Object? weekendUsageHours = null,Object? collectedAt = freezed,}) {
  return _then(_self.copyWith(
dailyUsageHours: null == dailyUsageHours ? _self.dailyUsageHours : dailyUsageHours // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [PhoneUsageMetrics].
extension PhoneUsageMetricsPatterns on PhoneUsageMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneUsageMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneUsageMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneUsageMetrics value)  $default,){
final _that = this;
switch (_that) {
case _PhoneUsageMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneUsageMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneUsageMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'daily_usage_hours')  double dailyUsageHours, @JsonKey(name: 'screen_time_before_bed')  double screenTimeBeforeBed, @JsonKey(name: 'phone_check_per_day')  int phoneCheckPerDay, @JsonKey(name: 'apps_used_daily')  int appsUsedDaily, @JsonKey(name: 'time_on_social_media')  double timeOnSocialMedia, @JsonKey(name: 'time_in_gaming')  double timeInGaming, @JsonKey(name: 'weekend_usage_hours')  double weekendUsageHours, @JsonKey(name: 'collected_at')  DateTime? collectedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneUsageMetrics() when $default != null:
return $default(_that.dailyUsageHours,_that.screenTimeBeforeBed,_that.phoneCheckPerDay,_that.appsUsedDaily,_that.timeOnSocialMedia,_that.timeInGaming,_that.weekendUsageHours,_that.collectedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'daily_usage_hours')  double dailyUsageHours, @JsonKey(name: 'screen_time_before_bed')  double screenTimeBeforeBed, @JsonKey(name: 'phone_check_per_day')  int phoneCheckPerDay, @JsonKey(name: 'apps_used_daily')  int appsUsedDaily, @JsonKey(name: 'time_on_social_media')  double timeOnSocialMedia, @JsonKey(name: 'time_in_gaming')  double timeInGaming, @JsonKey(name: 'weekend_usage_hours')  double weekendUsageHours, @JsonKey(name: 'collected_at')  DateTime? collectedAt)  $default,) {final _that = this;
switch (_that) {
case _PhoneUsageMetrics():
return $default(_that.dailyUsageHours,_that.screenTimeBeforeBed,_that.phoneCheckPerDay,_that.appsUsedDaily,_that.timeOnSocialMedia,_that.timeInGaming,_that.weekendUsageHours,_that.collectedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'daily_usage_hours')  double dailyUsageHours, @JsonKey(name: 'screen_time_before_bed')  double screenTimeBeforeBed, @JsonKey(name: 'phone_check_per_day')  int phoneCheckPerDay, @JsonKey(name: 'apps_used_daily')  int appsUsedDaily, @JsonKey(name: 'time_on_social_media')  double timeOnSocialMedia, @JsonKey(name: 'time_in_gaming')  double timeInGaming, @JsonKey(name: 'weekend_usage_hours')  double weekendUsageHours, @JsonKey(name: 'collected_at')  DateTime? collectedAt)?  $default,) {final _that = this;
switch (_that) {
case _PhoneUsageMetrics() when $default != null:
return $default(_that.dailyUsageHours,_that.screenTimeBeforeBed,_that.phoneCheckPerDay,_that.appsUsedDaily,_that.timeOnSocialMedia,_that.timeInGaming,_that.weekendUsageHours,_that.collectedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneUsageMetrics implements PhoneUsageMetrics {
  const _PhoneUsageMetrics({@JsonKey(name: 'daily_usage_hours') this.dailyUsageHours = 0.0, @JsonKey(name: 'screen_time_before_bed') this.screenTimeBeforeBed = 0.0, @JsonKey(name: 'phone_check_per_day') this.phoneCheckPerDay = 0, @JsonKey(name: 'apps_used_daily') this.appsUsedDaily = 0, @JsonKey(name: 'time_on_social_media') this.timeOnSocialMedia = 0.0, @JsonKey(name: 'time_in_gaming') this.timeInGaming = 0.0, @JsonKey(name: 'weekend_usage_hours') this.weekendUsageHours = 0.0, @JsonKey(name: 'collected_at') this.collectedAt});
  factory _PhoneUsageMetrics.fromJson(Map<String, dynamic> json) => _$PhoneUsageMetricsFromJson(json);

@override@JsonKey(name: 'daily_usage_hours') final  double dailyUsageHours;
@override@JsonKey(name: 'screen_time_before_bed') final  double screenTimeBeforeBed;
@override@JsonKey(name: 'phone_check_per_day') final  int phoneCheckPerDay;
@override@JsonKey(name: 'apps_used_daily') final  int appsUsedDaily;
@override@JsonKey(name: 'time_on_social_media') final  double timeOnSocialMedia;
@override@JsonKey(name: 'time_in_gaming') final  double timeInGaming;
@override@JsonKey(name: 'weekend_usage_hours') final  double weekendUsageHours;
@override@JsonKey(name: 'collected_at') final  DateTime? collectedAt;

/// Create a copy of PhoneUsageMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneUsageMetricsCopyWith<_PhoneUsageMetrics> get copyWith => __$PhoneUsageMetricsCopyWithImpl<_PhoneUsageMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhoneUsageMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneUsageMetrics&&(identical(other.dailyUsageHours, dailyUsageHours) || other.dailyUsageHours == dailyUsageHours)&&(identical(other.screenTimeBeforeBed, screenTimeBeforeBed) || other.screenTimeBeforeBed == screenTimeBeforeBed)&&(identical(other.phoneCheckPerDay, phoneCheckPerDay) || other.phoneCheckPerDay == phoneCheckPerDay)&&(identical(other.appsUsedDaily, appsUsedDaily) || other.appsUsedDaily == appsUsedDaily)&&(identical(other.timeOnSocialMedia, timeOnSocialMedia) || other.timeOnSocialMedia == timeOnSocialMedia)&&(identical(other.timeInGaming, timeInGaming) || other.timeInGaming == timeInGaming)&&(identical(other.weekendUsageHours, weekendUsageHours) || other.weekendUsageHours == weekendUsageHours)&&(identical(other.collectedAt, collectedAt) || other.collectedAt == collectedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dailyUsageHours,screenTimeBeforeBed,phoneCheckPerDay,appsUsedDaily,timeOnSocialMedia,timeInGaming,weekendUsageHours,collectedAt);

@override
String toString() {
  return 'PhoneUsageMetrics(dailyUsageHours: $dailyUsageHours, screenTimeBeforeBed: $screenTimeBeforeBed, phoneCheckPerDay: $phoneCheckPerDay, appsUsedDaily: $appsUsedDaily, timeOnSocialMedia: $timeOnSocialMedia, timeInGaming: $timeInGaming, weekendUsageHours: $weekendUsageHours, collectedAt: $collectedAt)';
}


}

/// @nodoc
abstract mixin class _$PhoneUsageMetricsCopyWith<$Res> implements $PhoneUsageMetricsCopyWith<$Res> {
  factory _$PhoneUsageMetricsCopyWith(_PhoneUsageMetrics value, $Res Function(_PhoneUsageMetrics) _then) = __$PhoneUsageMetricsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'daily_usage_hours') double dailyUsageHours,@JsonKey(name: 'screen_time_before_bed') double screenTimeBeforeBed,@JsonKey(name: 'phone_check_per_day') int phoneCheckPerDay,@JsonKey(name: 'apps_used_daily') int appsUsedDaily,@JsonKey(name: 'time_on_social_media') double timeOnSocialMedia,@JsonKey(name: 'time_in_gaming') double timeInGaming,@JsonKey(name: 'weekend_usage_hours') double weekendUsageHours,@JsonKey(name: 'collected_at') DateTime? collectedAt
});




}
/// @nodoc
class __$PhoneUsageMetricsCopyWithImpl<$Res>
    implements _$PhoneUsageMetricsCopyWith<$Res> {
  __$PhoneUsageMetricsCopyWithImpl(this._self, this._then);

  final _PhoneUsageMetrics _self;
  final $Res Function(_PhoneUsageMetrics) _then;

/// Create a copy of PhoneUsageMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dailyUsageHours = null,Object? screenTimeBeforeBed = null,Object? phoneCheckPerDay = null,Object? appsUsedDaily = null,Object? timeOnSocialMedia = null,Object? timeInGaming = null,Object? weekendUsageHours = null,Object? collectedAt = freezed,}) {
  return _then(_PhoneUsageMetrics(
dailyUsageHours: null == dailyUsageHours ? _self.dailyUsageHours : dailyUsageHours // ignore: cast_nullable_to_non_nullable
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
