// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weenat_org.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeenatOrg {

 int? get id; String? get name;
/// Create a copy of WeenatOrg
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeenatOrgCopyWith<WeenatOrg> get copyWith => _$WeenatOrgCopyWithImpl<WeenatOrg>(this as WeenatOrg, _$identity);

  /// Serializes this WeenatOrg to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeenatOrg&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'WeenatOrg(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $WeenatOrgCopyWith<$Res>  {
  factory $WeenatOrgCopyWith(WeenatOrg value, $Res Function(WeenatOrg) _then) = _$WeenatOrgCopyWithImpl;
@useResult
$Res call({
 int? id, String? name
});




}
/// @nodoc
class _$WeenatOrgCopyWithImpl<$Res>
    implements $WeenatOrgCopyWith<$Res> {
  _$WeenatOrgCopyWithImpl(this._self, this._then);

  final WeenatOrg _self;
  final $Res Function(WeenatOrg) _then;

/// Create a copy of WeenatOrg
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc

@JsonSerializable(explicitToJson: true)
class _WeenatOrg implements WeenatOrg {
  const _WeenatOrg({this.id, this.name});
  factory _WeenatOrg.fromJson(Map<String, dynamic> json) => _$WeenatOrgFromJson(json);

@override final  int? id;
@override final  String? name;

/// Create a copy of WeenatOrg
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeenatOrgCopyWith<_WeenatOrg> get copyWith => __$WeenatOrgCopyWithImpl<_WeenatOrg>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeenatOrgToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeenatOrg&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'WeenatOrg(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$WeenatOrgCopyWith<$Res> implements $WeenatOrgCopyWith<$Res> {
  factory _$WeenatOrgCopyWith(_WeenatOrg value, $Res Function(_WeenatOrg) _then) = __$WeenatOrgCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? name
});




}
/// @nodoc
class __$WeenatOrgCopyWithImpl<$Res>
    implements _$WeenatOrgCopyWith<$Res> {
  __$WeenatOrgCopyWithImpl(this._self, this._then);

  final _WeenatOrg _self;
  final $Res Function(_WeenatOrg) _then;

/// Create a copy of WeenatOrg
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,}) {
  return _then(_WeenatOrg(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
