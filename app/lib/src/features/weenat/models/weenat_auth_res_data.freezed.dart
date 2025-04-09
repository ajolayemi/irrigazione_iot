// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weenat_auth_res_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeenatAuthResData {

 String? get token;
/// Create a copy of WeenatAuthResData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeenatAuthResDataCopyWith<WeenatAuthResData> get copyWith => _$WeenatAuthResDataCopyWithImpl<WeenatAuthResData>(this as WeenatAuthResData, _$identity);

  /// Serializes this WeenatAuthResData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeenatAuthResData&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'WeenatAuthResData(token: $token)';
}


}

/// @nodoc
abstract mixin class $WeenatAuthResDataCopyWith<$Res>  {
  factory $WeenatAuthResDataCopyWith(WeenatAuthResData value, $Res Function(WeenatAuthResData) _then) = _$WeenatAuthResDataCopyWithImpl;
@useResult
$Res call({
 String? token
});




}
/// @nodoc
class _$WeenatAuthResDataCopyWithImpl<$Res>
    implements $WeenatAuthResDataCopyWith<$Res> {
  _$WeenatAuthResDataCopyWithImpl(this._self, this._then);

  final WeenatAuthResData _self;
  final $Res Function(WeenatAuthResData) _then;

/// Create a copy of WeenatAuthResData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = freezed,}) {
  return _then(_self.copyWith(
token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _WeenatAuthResData implements WeenatAuthResData {
  const _WeenatAuthResData({this.token});
  factory _WeenatAuthResData.fromJson(Map<String, dynamic> json) => _$WeenatAuthResDataFromJson(json);

@override final  String? token;

/// Create a copy of WeenatAuthResData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeenatAuthResDataCopyWith<_WeenatAuthResData> get copyWith => __$WeenatAuthResDataCopyWithImpl<_WeenatAuthResData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeenatAuthResDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeenatAuthResData&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'WeenatAuthResData(token: $token)';
}


}

/// @nodoc
abstract mixin class _$WeenatAuthResDataCopyWith<$Res> implements $WeenatAuthResDataCopyWith<$Res> {
  factory _$WeenatAuthResDataCopyWith(_WeenatAuthResData value, $Res Function(_WeenatAuthResData) _then) = __$WeenatAuthResDataCopyWithImpl;
@override @useResult
$Res call({
 String? token
});




}
/// @nodoc
class __$WeenatAuthResDataCopyWithImpl<$Res>
    implements _$WeenatAuthResDataCopyWith<$Res> {
  __$WeenatAuthResDataCopyWithImpl(this._self, this._then);

  final _WeenatAuthResData _self;
  final $Res Function(_WeenatAuthResData) _then;

/// Create a copy of WeenatAuthResData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = freezed,}) {
  return _then(_WeenatAuthResData(
token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
