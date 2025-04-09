// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weenat_auth_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeenatAuthPayload {

 String? get email; String? get password;
/// Create a copy of WeenatAuthPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeenatAuthPayloadCopyWith<WeenatAuthPayload> get copyWith => _$WeenatAuthPayloadCopyWithImpl<WeenatAuthPayload>(this as WeenatAuthPayload, _$identity);

  /// Serializes this WeenatAuthPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeenatAuthPayload&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'WeenatAuthPayload(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $WeenatAuthPayloadCopyWith<$Res>  {
  factory $WeenatAuthPayloadCopyWith(WeenatAuthPayload value, $Res Function(WeenatAuthPayload) _then) = _$WeenatAuthPayloadCopyWithImpl;
@useResult
$Res call({
 String? email, String? password
});




}
/// @nodoc
class _$WeenatAuthPayloadCopyWithImpl<$Res>
    implements $WeenatAuthPayloadCopyWith<$Res> {
  _$WeenatAuthPayloadCopyWithImpl(this._self, this._then);

  final WeenatAuthPayload _self;
  final $Res Function(WeenatAuthPayload) _then;

/// Create a copy of WeenatAuthPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = freezed,Object? password = freezed,}) {
  return _then(_self.copyWith(
email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _WeenatAuthPayload implements WeenatAuthPayload {
  const _WeenatAuthPayload({this.email, this.password});
  factory _WeenatAuthPayload.fromJson(Map<String, dynamic> json) => _$WeenatAuthPayloadFromJson(json);

@override final  String? email;
@override final  String? password;

/// Create a copy of WeenatAuthPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeenatAuthPayloadCopyWith<_WeenatAuthPayload> get copyWith => __$WeenatAuthPayloadCopyWithImpl<_WeenatAuthPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeenatAuthPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeenatAuthPayload&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'WeenatAuthPayload(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$WeenatAuthPayloadCopyWith<$Res> implements $WeenatAuthPayloadCopyWith<$Res> {
  factory _$WeenatAuthPayloadCopyWith(_WeenatAuthPayload value, $Res Function(_WeenatAuthPayload) _then) = __$WeenatAuthPayloadCopyWithImpl;
@override @useResult
$Res call({
 String? email, String? password
});




}
/// @nodoc
class __$WeenatAuthPayloadCopyWithImpl<$Res>
    implements _$WeenatAuthPayloadCopyWith<$Res> {
  __$WeenatAuthPayloadCopyWithImpl(this._self, this._then);

  final _WeenatAuthPayload _self;
  final $Res Function(_WeenatAuthPayload) _then;

/// Create a copy of WeenatAuthPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = freezed,Object? password = freezed,}) {
  return _then(_WeenatAuthPayload(
email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
