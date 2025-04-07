// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weenat_auth_res_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeenatAuthResData _$WeenatAuthResDataFromJson(Map<String, dynamic> json) {
  return _WeenatAuthResData.fromJson(json);
}

/// @nodoc
mixin _$WeenatAuthResData {
  String? get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeenatAuthResDataCopyWith<WeenatAuthResData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeenatAuthResDataCopyWith<$Res> {
  factory $WeenatAuthResDataCopyWith(
          WeenatAuthResData value, $Res Function(WeenatAuthResData) then) =
      _$WeenatAuthResDataCopyWithImpl<$Res, WeenatAuthResData>;
  @useResult
  $Res call({String? token});
}

/// @nodoc
class _$WeenatAuthResDataCopyWithImpl<$Res, $Val extends WeenatAuthResData>
    implements $WeenatAuthResDataCopyWith<$Res> {
  _$WeenatAuthResDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeenatAuthResDataImplCopyWith<$Res>
    implements $WeenatAuthResDataCopyWith<$Res> {
  factory _$$WeenatAuthResDataImplCopyWith(_$WeenatAuthResDataImpl value,
          $Res Function(_$WeenatAuthResDataImpl) then) =
      __$$WeenatAuthResDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? token});
}

/// @nodoc
class __$$WeenatAuthResDataImplCopyWithImpl<$Res>
    extends _$WeenatAuthResDataCopyWithImpl<$Res, _$WeenatAuthResDataImpl>
    implements _$$WeenatAuthResDataImplCopyWith<$Res> {
  __$$WeenatAuthResDataImplCopyWithImpl(_$WeenatAuthResDataImpl _value,
      $Res Function(_$WeenatAuthResDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
  }) {
    return _then(_$WeenatAuthResDataImpl(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeenatAuthResDataImpl extends _WeenatAuthResData {
  const _$WeenatAuthResDataImpl({this.token}) : super._();

  factory _$WeenatAuthResDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeenatAuthResDataImplFromJson(json);

  @override
  final String? token;

  @override
  String toString() {
    return 'WeenatAuthResData(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeenatAuthResDataImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeenatAuthResDataImplCopyWith<_$WeenatAuthResDataImpl> get copyWith =>
      __$$WeenatAuthResDataImplCopyWithImpl<_$WeenatAuthResDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeenatAuthResDataImplToJson(
      this,
    );
  }
}

abstract class _WeenatAuthResData extends WeenatAuthResData {
  const factory _WeenatAuthResData({final String? token}) =
      _$WeenatAuthResDataImpl;
  const _WeenatAuthResData._() : super._();

  factory _WeenatAuthResData.fromJson(Map<String, dynamic> json) =
      _$WeenatAuthResDataImpl.fromJson;

  @override
  String? get token;
  @override
  @JsonKey(ignore: true)
  _$$WeenatAuthResDataImplCopyWith<_$WeenatAuthResDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
