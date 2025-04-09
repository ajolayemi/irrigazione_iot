// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weenat_sensor_data_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeenatSensorDataPayload {
  int get start;
  int get end;
  @JsonKey(name: 'plot_id')
  int get plotId;
  int? get organization;

  /// Create a copy of WeenatSensorDataPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WeenatSensorDataPayloadCopyWith<WeenatSensorDataPayload> get copyWith =>
      _$WeenatSensorDataPayloadCopyWithImpl<WeenatSensorDataPayload>(
          this as WeenatSensorDataPayload, _$identity);

  /// Serializes this WeenatSensorDataPayload to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WeenatSensorDataPayload &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.plotId, plotId) || other.plotId == plotId) &&
            (identical(other.organization, organization) ||
                other.organization == organization));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, start, end, plotId, organization);

  @override
  String toString() {
    return 'WeenatSensorDataPayload(start: $start, end: $end, plotId: $plotId, organization: $organization)';
  }
}

/// @nodoc
abstract mixin class $WeenatSensorDataPayloadCopyWith<$Res> {
  factory $WeenatSensorDataPayloadCopyWith(WeenatSensorDataPayload value,
          $Res Function(WeenatSensorDataPayload) _then) =
      _$WeenatSensorDataPayloadCopyWithImpl;
  @useResult
  $Res call(
      {int start,
      int end,
      @JsonKey(name: 'plot_id') int plotId,
      int? organization});
}

/// @nodoc
class _$WeenatSensorDataPayloadCopyWithImpl<$Res>
    implements $WeenatSensorDataPayloadCopyWith<$Res> {
  _$WeenatSensorDataPayloadCopyWithImpl(this._self, this._then);

  final WeenatSensorDataPayload _self;
  final $Res Function(WeenatSensorDataPayload) _then;

  /// Create a copy of WeenatSensorDataPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? plotId = null,
    Object? organization = freezed,
  }) {
    return _then(_self.copyWith(
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      end: null == end
          ? _self.end
          : end // ignore: cast_nullable_to_non_nullable
              as int,
      plotId: null == plotId
          ? _self.plotId
          : plotId // ignore: cast_nullable_to_non_nullable
              as int,
      organization: freezed == organization
          ? _self.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WeenatSensorDataPayload extends WeenatSensorDataPayload {
  const _WeenatSensorDataPayload(
      {required this.start,
      required this.end,
      @JsonKey(name: 'plot_id') required this.plotId,
      this.organization})
      : super._();
  factory _WeenatSensorDataPayload.fromJson(Map<String, dynamic> json) =>
      _$WeenatSensorDataPayloadFromJson(json);

  @override
  final int start;
  @override
  final int end;
  @override
  @JsonKey(name: 'plot_id')
  final int plotId;
  @override
  final int? organization;

  /// Create a copy of WeenatSensorDataPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WeenatSensorDataPayloadCopyWith<_WeenatSensorDataPayload> get copyWith =>
      __$WeenatSensorDataPayloadCopyWithImpl<_WeenatSensorDataPayload>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WeenatSensorDataPayloadToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WeenatSensorDataPayload &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.plotId, plotId) || other.plotId == plotId) &&
            (identical(other.organization, organization) ||
                other.organization == organization));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, start, end, plotId, organization);

  @override
  String toString() {
    return 'WeenatSensorDataPayload(start: $start, end: $end, plotId: $plotId, organization: $organization)';
  }
}

/// @nodoc
abstract mixin class _$WeenatSensorDataPayloadCopyWith<$Res>
    implements $WeenatSensorDataPayloadCopyWith<$Res> {
  factory _$WeenatSensorDataPayloadCopyWith(_WeenatSensorDataPayload value,
          $Res Function(_WeenatSensorDataPayload) _then) =
      __$WeenatSensorDataPayloadCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int start,
      int end,
      @JsonKey(name: 'plot_id') int plotId,
      int? organization});
}

/// @nodoc
class __$WeenatSensorDataPayloadCopyWithImpl<$Res>
    implements _$WeenatSensorDataPayloadCopyWith<$Res> {
  __$WeenatSensorDataPayloadCopyWithImpl(this._self, this._then);

  final _WeenatSensorDataPayload _self;
  final $Res Function(_WeenatSensorDataPayload) _then;

  /// Create a copy of WeenatSensorDataPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? plotId = null,
    Object? organization = freezed,
  }) {
    return _then(_WeenatSensorDataPayload(
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      end: null == end
          ? _self.end
          : end // ignore: cast_nullable_to_non_nullable
              as int,
      plotId: null == plotId
          ? _self.plotId
          : plotId // ignore: cast_nullable_to_non_nullable
              as int,
      organization: freezed == organization
          ? _self.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
