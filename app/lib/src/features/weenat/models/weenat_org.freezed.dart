// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weenat_org.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeenatOrg _$WeenatOrgFromJson(Map<String, dynamic> json) {
  return _WeenatOrg.fromJson(json);
}

/// @nodoc
mixin _$WeenatOrg {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeenatOrgCopyWith<WeenatOrg> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeenatOrgCopyWith<$Res> {
  factory $WeenatOrgCopyWith(WeenatOrg value, $Res Function(WeenatOrg) then) =
      _$WeenatOrgCopyWithImpl<$Res, WeenatOrg>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$WeenatOrgCopyWithImpl<$Res, $Val extends WeenatOrg>
    implements $WeenatOrgCopyWith<$Res> {
  _$WeenatOrgCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeenatOrgImplCopyWith<$Res>
    implements $WeenatOrgCopyWith<$Res> {
  factory _$$WeenatOrgImplCopyWith(
          _$WeenatOrgImpl value, $Res Function(_$WeenatOrgImpl) then) =
      __$$WeenatOrgImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$WeenatOrgImplCopyWithImpl<$Res>
    extends _$WeenatOrgCopyWithImpl<$Res, _$WeenatOrgImpl>
    implements _$$WeenatOrgImplCopyWith<$Res> {
  __$$WeenatOrgImplCopyWithImpl(
      _$WeenatOrgImpl _value, $Res Function(_$WeenatOrgImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$WeenatOrgImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$WeenatOrgImpl extends _WeenatOrg {
  const _$WeenatOrgImpl({this.id, this.name}) : super._();

  factory _$WeenatOrgImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeenatOrgImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'WeenatOrg(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeenatOrgImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeenatOrgImplCopyWith<_$WeenatOrgImpl> get copyWith =>
      __$$WeenatOrgImplCopyWithImpl<_$WeenatOrgImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeenatOrgImplToJson(
      this,
    );
  }
}

abstract class _WeenatOrg extends WeenatOrg {
  const factory _WeenatOrg({final int? id, final String? name}) =
      _$WeenatOrgImpl;
  const _WeenatOrg._() : super._();

  factory _WeenatOrg.fromJson(Map<String, dynamic> json) =
      _$WeenatOrgImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$WeenatOrgImplCopyWith<_$WeenatOrgImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
