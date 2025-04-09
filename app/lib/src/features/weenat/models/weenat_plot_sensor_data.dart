import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irrigazione_iot/src/config/enums/weenat_sensor_data_types.dart';

part 'weenat_plot_sensor_data.freezed.dart';
part 'weenat_plot_sensor_data.g.dart';

/// A class representation of data needed to plot sensor data
@freezed
abstract class WeenatPlotSensorData with _$WeenatPlotSensorData {
  static const sensorDataKey = 'sensorData';
  static const dataTypeKey = 'dataType';
  static const sensorDataDepthKey = 'sensorDataDepth';
  static const timeStampKey = 'timeStamp';
  static const plotIdKey = 'plotId';
  static const idKey = 'id';

  const WeenatPlotSensorData._();

  const factory WeenatPlotSensorData({
    /// Primarily local database data id
    int? id,

    /// The related sensor data, which could be soil temperature
    /// or water potential at different depths
    @JsonKey(name: 'sensorData') double? sensorData,

    /// The depth at which the sensor data is associated with
    @JsonKey(name: 'sensorDataDepth') double? sensorDataDepth,

    /// The type of sensor data
    @JsonKey(name: 'dataType') WeenatSensorDataType? dataType,

    /// The timestamp of when this data was registered
    DateTime? timeStamp,

    /// The id of the plot to which this data belongs to
    int? plotId,
  }) = _WeenatPlotSensorData;

  factory WeenatPlotSensorData.fromJson(Map<String, dynamic> json) =>
      _$WeenatPlotSensorDataFromJson(json);

}
