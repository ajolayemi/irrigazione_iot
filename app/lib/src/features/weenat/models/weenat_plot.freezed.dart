// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weenat_plot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeenatPlot _$WeenatPlotFromJson(Map<String, dynamic> json) {
  return _WeenatPlot.fromJson(json);
}

/// @nodoc
mixin _$WeenatPlot {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'latitude')
  double? get lat => throw _privateConstructorUsedError;
  @JsonKey(name: 'longitude')
  double? get lng => throw _privateConstructorUsedError;
  @JsonKey(name: 'organization')
  WeenatOrg? get org => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_count')
  int? get deviceCount => throw _privateConstructorUsedError;
  DateTime? get lastUpdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeenatPlotCopyWith<WeenatPlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeenatPlotCopyWith<$Res> {
  factory $WeenatPlotCopyWith(
          WeenatPlot value, $Res Function(WeenatPlot) then) =
      _$WeenatPlotCopyWithImpl<$Res, WeenatPlot>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      @JsonKey(name: 'latitude') double? lat,
      @JsonKey(name: 'longitude') double? lng,
      @JsonKey(name: 'organization') WeenatOrg? org,
      @JsonKey(name: 'device_count') int? deviceCount,
      DateTime? lastUpdate});

  $WeenatOrgCopyWith<$Res>? get org;
}

/// @nodoc
class _$WeenatPlotCopyWithImpl<$Res, $Val extends WeenatPlot>
    implements $WeenatPlotCopyWith<$Res> {
  _$WeenatPlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? org = freezed,
    Object? deviceCount = freezed,
    Object? lastUpdate = freezed,
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
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      lng: freezed == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double?,
      org: freezed == org
          ? _value.org
          : org // ignore: cast_nullable_to_non_nullable
              as WeenatOrg?,
      deviceCount: freezed == deviceCount
          ? _value.deviceCount
          : deviceCount // ignore: cast_nullable_to_non_nullable
              as int?,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WeenatOrgCopyWith<$Res>? get org {
    if (_value.org == null) {
      return null;
    }

    return $WeenatOrgCopyWith<$Res>(_value.org!, (value) {
      return _then(_value.copyWith(org: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WeenatPlotImplCopyWith<$Res>
    implements $WeenatPlotCopyWith<$Res> {
  factory _$$WeenatPlotImplCopyWith(
          _$WeenatPlotImpl value, $Res Function(_$WeenatPlotImpl) then) =
      __$$WeenatPlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      @JsonKey(name: 'latitude') double? lat,
      @JsonKey(name: 'longitude') double? lng,
      @JsonKey(name: 'organization') WeenatOrg? org,
      @JsonKey(name: 'device_count') int? deviceCount,
      DateTime? lastUpdate});

  @override
  $WeenatOrgCopyWith<$Res>? get org;
}

/// @nodoc
class __$$WeenatPlotImplCopyWithImpl<$Res>
    extends _$WeenatPlotCopyWithImpl<$Res, _$WeenatPlotImpl>
    implements _$$WeenatPlotImplCopyWith<$Res> {
  __$$WeenatPlotImplCopyWithImpl(
      _$WeenatPlotImpl _value, $Res Function(_$WeenatPlotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? org = freezed,
    Object? deviceCount = freezed,
    Object? lastUpdate = freezed,
  }) {
    return _then(_$WeenatPlotImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      lng: freezed == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double?,
      org: freezed == org
          ? _value.org
          : org // ignore: cast_nullable_to_non_nullable
              as WeenatOrg?,
      deviceCount: freezed == deviceCount
          ? _value.deviceCount
          : deviceCount // ignore: cast_nullable_to_non_nullable
              as int?,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$WeenatPlotImpl extends _WeenatPlot {
  const _$WeenatPlotImpl(
      {this.id,
      this.name,
      @JsonKey(name: 'latitude') this.lat,
      @JsonKey(name: 'longitude') this.lng,
      @JsonKey(name: 'organization') this.org,
      @JsonKey(name: 'device_count') this.deviceCount,
      this.lastUpdate})
      : super._();

  factory _$WeenatPlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeenatPlotImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  @JsonKey(name: 'latitude')
  final double? lat;
  @override
  @JsonKey(name: 'longitude')
  final double? lng;
  @override
  @JsonKey(name: 'organization')
  final WeenatOrg? org;
  @override
  @JsonKey(name: 'device_count')
  final int? deviceCount;
  @override
  final DateTime? lastUpdate;

  @override
  String toString() {
    return 'WeenatPlot(id: $id, name: $name, lat: $lat, lng: $lng, org: $org, deviceCount: $deviceCount, lastUpdate: $lastUpdate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeenatPlotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.org, org) || other.org == org) &&
            (identical(other.deviceCount, deviceCount) ||
                other.deviceCount == deviceCount) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, lat, lng, org, deviceCount, lastUpdate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeenatPlotImplCopyWith<_$WeenatPlotImpl> get copyWith =>
      __$$WeenatPlotImplCopyWithImpl<_$WeenatPlotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeenatPlotImplToJson(
      this,
    );
  }
}

abstract class _WeenatPlot extends WeenatPlot {
  const factory _WeenatPlot(
      {final int? id,
      final String? name,
      @JsonKey(name: 'latitude') final double? lat,
      @JsonKey(name: 'longitude') final double? lng,
      @JsonKey(name: 'organization') final WeenatOrg? org,
      @JsonKey(name: 'device_count') final int? deviceCount,
      final DateTime? lastUpdate}) = _$WeenatPlotImpl;
  const _WeenatPlot._() : super._();

  factory _WeenatPlot.fromJson(Map<String, dynamic> json) =
      _$WeenatPlotImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  @JsonKey(name: 'latitude')
  double? get lat;
  @override
  @JsonKey(name: 'longitude')
  double? get lng;
  @override
  @JsonKey(name: 'organization')
  WeenatOrg? get org;
  @override
  @JsonKey(name: 'device_count')
  int? get deviceCount;
  @override
  DateTime? get lastUpdate;
  @override
  @JsonKey(ignore: true)
  _$$WeenatPlotImplCopyWith<_$WeenatPlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
