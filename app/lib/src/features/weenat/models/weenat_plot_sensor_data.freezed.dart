// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weenat_plot_sensor_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeenatPlotSensorData {

/// Primarily local database data id
 int? get id;/// The related sensor data, which could be soil temperature
/// or water potential at different depths
@JsonKey(name: 'sensorData') double? get sensorData;/// The depth at which the sensor data is associated with
@JsonKey(name: 'sensorDataDepth') double? get sensorDataDepth;/// The type of sensor data
@JsonKey(name: 'dataType') WeenatSensorDataType? get dataType;/// The timestamp of when this data was registered
 DateTime? get timeStamp;/// The id of the plot to which this data belongs to
 int? get plotId;
/// Create a copy of WeenatPlotSensorData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeenatPlotSensorDataCopyWith<WeenatPlotSensorData> get copyWith => _$WeenatPlotSensorDataCopyWithImpl<WeenatPlotSensorData>(this as WeenatPlotSensorData, _$identity);

  /// Serializes this WeenatPlotSensorData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeenatPlotSensorData&&(identical(other.id, id) || other.id == id)&&(identical(other.sensorData, sensorData) || other.sensorData == sensorData)&&(identical(other.sensorDataDepth, sensorDataDepth) || other.sensorDataDepth == sensorDataDepth)&&(identical(other.dataType, dataType) || other.dataType == dataType)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp)&&(identical(other.plotId, plotId) || other.plotId == plotId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sensorData,sensorDataDepth,dataType,timeStamp,plotId);

@override
String toString() {
  return 'WeenatPlotSensorData(id: $id, sensorData: $sensorData, sensorDataDepth: $sensorDataDepth, dataType: $dataType, timeStamp: $timeStamp, plotId: $plotId)';
}


}

/// @nodoc
abstract mixin class $WeenatPlotSensorDataCopyWith<$Res>  {
  factory $WeenatPlotSensorDataCopyWith(WeenatPlotSensorData value, $Res Function(WeenatPlotSensorData) _then) = _$WeenatPlotSensorDataCopyWithImpl;
@useResult
$Res call({
 int? id,@JsonKey(name: 'sensorData') double? sensorData,@JsonKey(name: 'sensorDataDepth') double? sensorDataDepth,@JsonKey(name: 'dataType') WeenatSensorDataType? dataType, DateTime? timeStamp, int? plotId
});




}
/// @nodoc
class _$WeenatPlotSensorDataCopyWithImpl<$Res>
    implements $WeenatPlotSensorDataCopyWith<$Res> {
  _$WeenatPlotSensorDataCopyWithImpl(this._self, this._then);

  final WeenatPlotSensorData _self;
  final $Res Function(WeenatPlotSensorData) _then;

/// Create a copy of WeenatPlotSensorData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? sensorData = freezed,Object? sensorDataDepth = freezed,Object? dataType = freezed,Object? timeStamp = freezed,Object? plotId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,sensorData: freezed == sensorData ? _self.sensorData : sensorData // ignore: cast_nullable_to_non_nullable
as double?,sensorDataDepth: freezed == sensorDataDepth ? _self.sensorDataDepth : sensorDataDepth // ignore: cast_nullable_to_non_nullable
as double?,dataType: freezed == dataType ? _self.dataType : dataType // ignore: cast_nullable_to_non_nullable
as WeenatSensorDataType?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as DateTime?,plotId: freezed == plotId ? _self.plotId : plotId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _WeenatPlotSensorData extends WeenatPlotSensorData {
  const _WeenatPlotSensorData({this.id, @JsonKey(name: 'sensorData') this.sensorData, @JsonKey(name: 'sensorDataDepth') this.sensorDataDepth, @JsonKey(name: 'dataType') this.dataType, this.timeStamp, this.plotId}): super._();
  factory _WeenatPlotSensorData.fromJson(Map<String, dynamic> json) => _$WeenatPlotSensorDataFromJson(json);

/// Primarily local database data id
@override final  int? id;
/// The related sensor data, which could be soil temperature
/// or water potential at different depths
@override@JsonKey(name: 'sensorData') final  double? sensorData;
/// The depth at which the sensor data is associated with
@override@JsonKey(name: 'sensorDataDepth') final  double? sensorDataDepth;
/// The type of sensor data
@override@JsonKey(name: 'dataType') final  WeenatSensorDataType? dataType;
/// The timestamp of when this data was registered
@override final  DateTime? timeStamp;
/// The id of the plot to which this data belongs to
@override final  int? plotId;

/// Create a copy of WeenatPlotSensorData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeenatPlotSensorDataCopyWith<_WeenatPlotSensorData> get copyWith => __$WeenatPlotSensorDataCopyWithImpl<_WeenatPlotSensorData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeenatPlotSensorDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeenatPlotSensorData&&(identical(other.id, id) || other.id == id)&&(identical(other.sensorData, sensorData) || other.sensorData == sensorData)&&(identical(other.sensorDataDepth, sensorDataDepth) || other.sensorDataDepth == sensorDataDepth)&&(identical(other.dataType, dataType) || other.dataType == dataType)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp)&&(identical(other.plotId, plotId) || other.plotId == plotId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sensorData,sensorDataDepth,dataType,timeStamp,plotId);

@override
String toString() {
  return 'WeenatPlotSensorData(id: $id, sensorData: $sensorData, sensorDataDepth: $sensorDataDepth, dataType: $dataType, timeStamp: $timeStamp, plotId: $plotId)';
}


}

/// @nodoc
abstract mixin class _$WeenatPlotSensorDataCopyWith<$Res> implements $WeenatPlotSensorDataCopyWith<$Res> {
  factory _$WeenatPlotSensorDataCopyWith(_WeenatPlotSensorData value, $Res Function(_WeenatPlotSensorData) _then) = __$WeenatPlotSensorDataCopyWithImpl;
@override @useResult
$Res call({
 int? id,@JsonKey(name: 'sensorData') double? sensorData,@JsonKey(name: 'sensorDataDepth') double? sensorDataDepth,@JsonKey(name: 'dataType') WeenatSensorDataType? dataType, DateTime? timeStamp, int? plotId
});




}
/// @nodoc
class __$WeenatPlotSensorDataCopyWithImpl<$Res>
    implements _$WeenatPlotSensorDataCopyWith<$Res> {
  __$WeenatPlotSensorDataCopyWithImpl(this._self, this._then);

  final _WeenatPlotSensorData _self;
  final $Res Function(_WeenatPlotSensorData) _then;

/// Create a copy of WeenatPlotSensorData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? sensorData = freezed,Object? sensorDataDepth = freezed,Object? dataType = freezed,Object? timeStamp = freezed,Object? plotId = freezed,}) {
  return _then(_WeenatPlotSensorData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,sensorData: freezed == sensorData ? _self.sensorData : sensorData // ignore: cast_nullable_to_non_nullable
as double?,sensorDataDepth: freezed == sensorDataDepth ? _self.sensorDataDepth : sensorDataDepth // ignore: cast_nullable_to_non_nullable
as double?,dataType: freezed == dataType ? _self.dataType : dataType // ignore: cast_nullable_to_non_nullable
as WeenatSensorDataType?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as DateTime?,plotId: freezed == plotId ? _self.plotId : plotId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
