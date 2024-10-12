// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weenat_plot_org.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeenatPlotOrg _$WeenatPlotOrgFromJson(Map<String, dynamic> json) {
  return _WeenatPlotOrg.fromJson(json);
}

/// @nodoc
mixin _$WeenatPlotOrg {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeenatPlotOrgCopyWith<WeenatPlotOrg> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeenatPlotOrgCopyWith<$Res> {
  factory $WeenatPlotOrgCopyWith(
          WeenatPlotOrg value, $Res Function(WeenatPlotOrg) then) =
      _$WeenatPlotOrgCopyWithImpl<$Res, WeenatPlotOrg>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$WeenatPlotOrgCopyWithImpl<$Res, $Val extends WeenatPlotOrg>
    implements $WeenatPlotOrgCopyWith<$Res> {
  _$WeenatPlotOrgCopyWithImpl(this._value, this._then);

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
abstract class _$$WeenatPlotOrgImplCopyWith<$Res>
    implements $WeenatPlotOrgCopyWith<$Res> {
  factory _$$WeenatPlotOrgImplCopyWith(
          _$WeenatPlotOrgImpl value, $Res Function(_$WeenatPlotOrgImpl) then) =
      __$$WeenatPlotOrgImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$WeenatPlotOrgImplCopyWithImpl<$Res>
    extends _$WeenatPlotOrgCopyWithImpl<$Res, _$WeenatPlotOrgImpl>
    implements _$$WeenatPlotOrgImplCopyWith<$Res> {
  __$$WeenatPlotOrgImplCopyWithImpl(
      _$WeenatPlotOrgImpl _value, $Res Function(_$WeenatPlotOrgImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$WeenatPlotOrgImpl(
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
class _$WeenatPlotOrgImpl extends _WeenatPlotOrg {
  const _$WeenatPlotOrgImpl({this.id, this.name}) : super._();

  factory _$WeenatPlotOrgImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeenatPlotOrgImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'WeenatPlotOrg(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeenatPlotOrgImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeenatPlotOrgImplCopyWith<_$WeenatPlotOrgImpl> get copyWith =>
      __$$WeenatPlotOrgImplCopyWithImpl<_$WeenatPlotOrgImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeenatPlotOrgImplToJson(
      this,
    );
  }
}

abstract class _WeenatPlotOrg extends WeenatPlotOrg {
  const factory _WeenatPlotOrg({final int? id, final String? name}) =
      _$WeenatPlotOrgImpl;
  const _WeenatPlotOrg._() : super._();

  factory _WeenatPlotOrg.fromJson(Map<String, dynamic> json) =
      _$WeenatPlotOrgImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$WeenatPlotOrgImplCopyWith<_$WeenatPlotOrgImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
