// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weenat_plot_sensor_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeenatPlotSensorData _$WeenatPlotSensorDataFromJson(Map<String, dynamic> json) {
  return _WeenatPlotSensorData.fromJson(json);
}

/// @nodoc
mixin _$WeenatPlotSensorData {
  /// Primarily local database data id
  int? get id => throw _privateConstructorUsedError;

  /// The related sensor data, which could be soil temperature
  /// or water potential at different depths
  @JsonKey(name: 'sensorData')
  double? get sensorData => throw _privateConstructorUsedError;

  /// The depth at which the sensor data is associated with
  @JsonKey(name: 'sensorDataDepth')
  double? get sensorDataDepth => throw _privateConstructorUsedError;

  /// The type of sensor data
  @JsonKey(name: 'dataType')
  WeenatSensorDataType? get dataType => throw _privateConstructorUsedError;

  /// The timestamp of when this data was registered
  DateTime? get timeStamp => throw _privateConstructorUsedError;

  /// The id of the plot to which this data belongs to
  int? get plotId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeenatPlotSensorDataCopyWith<WeenatPlotSensorData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeenatPlotSensorDataCopyWith<$Res> {
  factory $WeenatPlotSensorDataCopyWith(WeenatPlotSensorData value,
          $Res Function(WeenatPlotSensorData) then) =
      _$WeenatPlotSensorDataCopyWithImpl<$Res, WeenatPlotSensorData>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'sensorData') double? sensorData,
      @JsonKey(name: 'sensorDataDepth') double? sensorDataDepth,
      @JsonKey(name: 'dataType') WeenatSensorDataType? dataType,
      DateTime? timeStamp,
      int? plotId});
}

/// @nodoc
class _$WeenatPlotSensorDataCopyWithImpl<$Res,
        $Val extends WeenatPlotSensorData>
    implements $WeenatPlotSensorDataCopyWith<$Res> {
  _$WeenatPlotSensorDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? sensorData = freezed,
    Object? sensorDataDepth = freezed,
    Object? dataType = freezed,
    Object? timeStamp = freezed,
    Object? plotId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      sensorData: freezed == sensorData
          ? _value.sensorData
          : sensorData // ignore: cast_nullable_to_non_nullable
              as double?,
      sensorDataDepth: freezed == sensorDataDepth
          ? _value.sensorDataDepth
          : sensorDataDepth // ignore: cast_nullable_to_non_nullable
              as double?,
      dataType: freezed == dataType
          ? _value.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as WeenatSensorDataType?,
      timeStamp: freezed == timeStamp
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      plotId: freezed == plotId
          ? _value.plotId
          : plotId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeenatPlotSensorDataImplCopyWith<$Res>
    implements $WeenatPlotSensorDataCopyWith<$Res> {
  factory _$$WeenatPlotSensorDataImplCopyWith(_$WeenatPlotSensorDataImpl value,
          $Res Function(_$WeenatPlotSensorDataImpl) then) =
      __$$WeenatPlotSensorDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'sensorData') double? sensorData,
      @JsonKey(name: 'sensorDataDepth') double? sensorDataDepth,
      @JsonKey(name: 'dataType') WeenatSensorDataType? dataType,
      DateTime? timeStamp,
      int? plotId});
}

/// @nodoc
class __$$WeenatPlotSensorDataImplCopyWithImpl<$Res>
    extends _$WeenatPlotSensorDataCopyWithImpl<$Res, _$WeenatPlotSensorDataImpl>
    implements _$$WeenatPlotSensorDataImplCopyWith<$Res> {
  __$$WeenatPlotSensorDataImplCopyWithImpl(_$WeenatPlotSensorDataImpl _value,
      $Res Function(_$WeenatPlotSensorDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? sensorData = freezed,
    Object? sensorDataDepth = freezed,
    Object? dataType = freezed,
    Object? timeStamp = freezed,
    Object? plotId = freezed,
  }) {
    return _then(_$WeenatPlotSensorDataImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      sensorData: freezed == sensorData
          ? _value.sensorData
          : sensorData // ignore: cast_nullable_to_non_nullable
              as double?,
      sensorDataDepth: freezed == sensorDataDepth
          ? _value.sensorDataDepth
          : sensorDataDepth // ignore: cast_nullable_to_non_nullable
              as double?,
      dataType: freezed == dataType
          ? _value.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as WeenatSensorDataType?,
      timeStamp: freezed == timeStamp
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      plotId: freezed == plotId
          ? _value.plotId
          : plotId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeenatPlotSensorDataImpl extends _WeenatPlotSensorData {
  const _$WeenatPlotSensorDataImpl(
      {this.id,
      @JsonKey(name: 'sensorData') this.sensorData,
      @JsonKey(name: 'sensorDataDepth') this.sensorDataDepth,
      @JsonKey(name: 'dataType') this.dataType,
      this.timeStamp,
      this.plotId})
      : super._();

  factory _$WeenatPlotSensorDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeenatPlotSensorDataImplFromJson(json);

  /// Primarily local database data id
  @override
  final int? id;

  /// The related sensor data, which could be soil temperature
  /// or water potential at different depths
  @override
  @JsonKey(name: 'sensorData')
  final double? sensorData;

  /// The depth at which the sensor data is associated with
  @override
  @JsonKey(name: 'sensorDataDepth')
  final double? sensorDataDepth;

  /// The type of sensor data
  @override
  @JsonKey(name: 'dataType')
  final WeenatSensorDataType? dataType;

  /// The timestamp of when this data was registered
  @override
  final DateTime? timeStamp;

  /// The id of the plot to which this data belongs to
  @override
  final int? plotId;

  @override
  String toString() {
    return 'WeenatPlotSensorData(id: $id, sensorData: $sensorData, sensorDataDepth: $sensorDataDepth, dataType: $dataType, timeStamp: $timeStamp, plotId: $plotId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeenatPlotSensorDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sensorData, sensorData) ||
                other.sensorData == sensorData) &&
            (identical(other.sensorDataDepth, sensorDataDepth) ||
                other.sensorDataDepth == sensorDataDepth) &&
            (identical(other.dataType, dataType) ||
                other.dataType == dataType) &&
            (identical(other.timeStamp, timeStamp) ||
                other.timeStamp == timeStamp) &&
            (identical(other.plotId, plotId) || other.plotId == plotId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, sensorData, sensorDataDepth,
      dataType, timeStamp, plotId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeenatPlotSensorDataImplCopyWith<_$WeenatPlotSensorDataImpl>
      get copyWith =>
          __$$WeenatPlotSensorDataImplCopyWithImpl<_$WeenatPlotSensorDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeenatPlotSensorDataImplToJson(
      this,
    );
  }
}

abstract class _WeenatPlotSensorData extends WeenatPlotSensorData {
  const factory _WeenatPlotSensorData(
      {final int? id,
      @JsonKey(name: 'sensorData') final double? sensorData,
      @JsonKey(name: 'sensorDataDepth') final double? sensorDataDepth,
      @JsonKey(name: 'dataType') final WeenatSensorDataType? dataType,
      final DateTime? timeStamp,
      final int? plotId}) = _$WeenatPlotSensorDataImpl;
  const _WeenatPlotSensorData._() : super._();

  factory _WeenatPlotSensorData.fromJson(Map<String, dynamic> json) =
      _$WeenatPlotSensorDataImpl.fromJson;

  @override

  /// Primarily local database data id
  int? get id;
  @override

  /// The related sensor data, which could be soil temperature
  /// or water potential at different depths
  @JsonKey(name: 'sensorData')
  double? get sensorData;
  @override

  /// The depth at which the sensor data is associated with
  @JsonKey(name: 'sensorDataDepth')
  double? get sensorDataDepth;
  @override

  /// The type of sensor data
  @JsonKey(name: 'dataType')
  WeenatSensorDataType? get dataType;
  @override

  /// The timestamp of when this data was registered
  DateTime? get timeStamp;
  @override

  /// The id of the plot to which this data belongs to
  int? get plotId;
  @override
  @JsonKey(ignore: true)
  _$$WeenatPlotSensorDataImplCopyWith<_$WeenatPlotSensorDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
