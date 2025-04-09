// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weenat_plot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeenatPlot {
  int? get id;
  String? get name;
  @JsonKey(name: 'latitude')
  double? get lat;
  @JsonKey(name: 'longitude')
  double? get lng;
  @JsonKey(name: 'organization')
  WeenatOrg? get org;
  @JsonKey(name: 'device_count')
  int? get deviceCount;
  DateTime? get lastUpdate;

  /// Create a copy of WeenatPlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WeenatPlotCopyWith<WeenatPlot> get copyWith =>
      _$WeenatPlotCopyWithImpl<WeenatPlot>(this as WeenatPlot, _$identity);

  /// Serializes this WeenatPlot to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WeenatPlot &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, lat, lng, org, deviceCount, lastUpdate);

  @override
  String toString() {
    return 'WeenatPlot(id: $id, name: $name, lat: $lat, lng: $lng, org: $org, deviceCount: $deviceCount, lastUpdate: $lastUpdate)';
  }
}

/// @nodoc
abstract mixin class $WeenatPlotCopyWith<$Res> {
  factory $WeenatPlotCopyWith(
          WeenatPlot value, $Res Function(WeenatPlot) _then) =
      _$WeenatPlotCopyWithImpl;
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
class _$WeenatPlotCopyWithImpl<$Res> implements $WeenatPlotCopyWith<$Res> {
  _$WeenatPlotCopyWithImpl(this._self, this._then);

  final WeenatPlot _self;
  final $Res Function(WeenatPlot) _then;

  /// Create a copy of WeenatPlot
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      lat: freezed == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      lng: freezed == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double?,
      org: freezed == org
          ? _self.org
          : org // ignore: cast_nullable_to_non_nullable
              as WeenatOrg?,
      deviceCount: freezed == deviceCount
          ? _self.deviceCount
          : deviceCount // ignore: cast_nullable_to_non_nullable
              as int?,
      lastUpdate: freezed == lastUpdate
          ? _self.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of WeenatPlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WeenatOrgCopyWith<$Res>? get org {
    if (_self.org == null) {
      return null;
    }

    return $WeenatOrgCopyWith<$Res>(_self.org!, (value) {
      return _then(_self.copyWith(org: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _WeenatPlot extends WeenatPlot {
  const _WeenatPlot(
      {this.id,
      this.name,
      @JsonKey(name: 'latitude') this.lat,
      @JsonKey(name: 'longitude') this.lng,
      @JsonKey(name: 'organization') this.org,
      @JsonKey(name: 'device_count') this.deviceCount,
      this.lastUpdate})
      : super._();
  factory _WeenatPlot.fromJson(Map<String, dynamic> json) =>
      _$WeenatPlotFromJson(json);

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

  /// Create a copy of WeenatPlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WeenatPlotCopyWith<_WeenatPlot> get copyWith =>
      __$WeenatPlotCopyWithImpl<_WeenatPlot>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WeenatPlotToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WeenatPlot &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, lat, lng, org, deviceCount, lastUpdate);

  @override
  String toString() {
    return 'WeenatPlot(id: $id, name: $name, lat: $lat, lng: $lng, org: $org, deviceCount: $deviceCount, lastUpdate: $lastUpdate)';
  }
}

/// @nodoc
abstract mixin class _$WeenatPlotCopyWith<$Res>
    implements $WeenatPlotCopyWith<$Res> {
  factory _$WeenatPlotCopyWith(
          _WeenatPlot value, $Res Function(_WeenatPlot) _then) =
      __$WeenatPlotCopyWithImpl;
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
class __$WeenatPlotCopyWithImpl<$Res> implements _$WeenatPlotCopyWith<$Res> {
  __$WeenatPlotCopyWithImpl(this._self, this._then);

  final _WeenatPlot _self;
  final $Res Function(_WeenatPlot) _then;

  /// Create a copy of WeenatPlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? org = freezed,
    Object? deviceCount = freezed,
    Object? lastUpdate = freezed,
  }) {
    return _then(_WeenatPlot(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      lat: freezed == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      lng: freezed == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double?,
      org: freezed == org
          ? _self.org
          : org // ignore: cast_nullable_to_non_nullable
              as WeenatOrg?,
      deviceCount: freezed == deviceCount
          ? _self.deviceCount
          : deviceCount // ignore: cast_nullable_to_non_nullable
              as int?,
      lastUpdate: freezed == lastUpdate
          ? _self.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of WeenatPlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WeenatOrgCopyWith<$Res>? get org {
    if (_self.org == null) {
      return null;
    }

    return $WeenatOrgCopyWith<$Res>(_self.org!, (value) {
      return _then(_self.copyWith(org: value));
    });
  }
}

// dart format on
