// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weenat_sensor_data_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeenatSensorDataPayload _$WeenatSensorDataPayloadFromJson(
    Map<String, dynamic> json) {
  return _WeenatSensorDataPayload.fromJson(json);
}

/// @nodoc
mixin _$WeenatSensorDataPayload {
  int get start => throw _privateConstructorUsedError;
  int get end => throw _privateConstructorUsedError;
  @JsonKey(name: 'plot_id')
  int get plotId => throw _privateConstructorUsedError;
  int? get organization => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeenatSensorDataPayloadCopyWith<WeenatSensorDataPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeenatSensorDataPayloadCopyWith<$Res> {
  factory $WeenatSensorDataPayloadCopyWith(WeenatSensorDataPayload value,
          $Res Function(WeenatSensorDataPayload) then) =
      _$WeenatSensorDataPayloadCopyWithImpl<$Res, WeenatSensorDataPayload>;
  @useResult
  $Res call(
      {int start,
      int end,
      @JsonKey(name: 'plot_id') int plotId,
      int? organization});
}

/// @nodoc
class _$WeenatSensorDataPayloadCopyWithImpl<$Res,
        $Val extends WeenatSensorDataPayload>
    implements $WeenatSensorDataPayloadCopyWith<$Res> {
  _$WeenatSensorDataPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? plotId = null,
    Object? organization = freezed,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int,
      plotId: null == plotId
          ? _value.plotId
          : plotId // ignore: cast_nullable_to_non_nullable
              as int,
      organization: freezed == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeenatSensorDataPayloadImplCopyWith<$Res>
    implements $WeenatSensorDataPayloadCopyWith<$Res> {
  factory _$$WeenatSensorDataPayloadImplCopyWith(
          _$WeenatSensorDataPayloadImpl value,
          $Res Function(_$WeenatSensorDataPayloadImpl) then) =
      __$$WeenatSensorDataPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int start,
      int end,
      @JsonKey(name: 'plot_id') int plotId,
      int? organization});
}

/// @nodoc
class __$$WeenatSensorDataPayloadImplCopyWithImpl<$Res>
    extends _$WeenatSensorDataPayloadCopyWithImpl<$Res,
        _$WeenatSensorDataPayloadImpl>
    implements _$$WeenatSensorDataPayloadImplCopyWith<$Res> {
  __$$WeenatSensorDataPayloadImplCopyWithImpl(
      _$WeenatSensorDataPayloadImpl _value,
      $Res Function(_$WeenatSensorDataPayloadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? plotId = null,
    Object? organization = freezed,
  }) {
    return _then(_$WeenatSensorDataPayloadImpl(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int,
      plotId: null == plotId
          ? _value.plotId
          : plotId // ignore: cast_nullable_to_non_nullable
              as int,
      organization: freezed == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeenatSensorDataPayloadImpl extends _WeenatSensorDataPayload {
  const _$WeenatSensorDataPayloadImpl(
      {required this.start,
      required this.end,
      @JsonKey(name: 'plot_id') required this.plotId,
      this.organization})
      : super._();

  factory _$WeenatSensorDataPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeenatSensorDataPayloadImplFromJson(json);

  @override
  final int start;
  @override
  final int end;
  @override
  @JsonKey(name: 'plot_id')
  final int plotId;
  @override
  final int? organization;

  @override
  String toString() {
    return 'WeenatSensorDataPayload(start: $start, end: $end, plotId: $plotId, organization: $organization)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeenatSensorDataPayloadImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.plotId, plotId) || other.plotId == plotId) &&
            (identical(other.organization, organization) ||
                other.organization == organization));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, start, end, plotId, organization);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeenatSensorDataPayloadImplCopyWith<_$WeenatSensorDataPayloadImpl>
      get copyWith => __$$WeenatSensorDataPayloadImplCopyWithImpl<
          _$WeenatSensorDataPayloadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeenatSensorDataPayloadImplToJson(
      this,
    );
  }
}

abstract class _WeenatSensorDataPayload extends WeenatSensorDataPayload {
  const factory _WeenatSensorDataPayload(
      {required final int start,
      required final int end,
      @JsonKey(name: 'plot_id') required final int plotId,
      final int? organization}) = _$WeenatSensorDataPayloadImpl;
  const _WeenatSensorDataPayload._() : super._();

  factory _WeenatSensorDataPayload.fromJson(Map<String, dynamic> json) =
      _$WeenatSensorDataPayloadImpl.fromJson;

  @override
  int get start;
  @override
  int get end;
  @override
  @JsonKey(name: 'plot_id')
  int get plotId;
  @override
  int? get organization;
  @override
  @JsonKey(ignore: true)
  _$$WeenatSensorDataPayloadImplCopyWith<_$WeenatSensorDataPayloadImpl>
      get copyWith => throw _privateConstructorUsedError;
}
