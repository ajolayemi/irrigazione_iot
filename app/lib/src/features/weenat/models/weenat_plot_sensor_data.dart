import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irrigazione_iot/src/config/enums/weenat_sensor_data_types.dart';
import 'package:irrigazione_iot/src/data/datasource/entities/weenat_plot_sensor_data_entity.dart';

part 'weenat_plot_sensor_data.freezed.dart';
part 'weenat_plot_sensor_data.g.dart';

/// A class representation of data needed to plot sensor data
@freezed
class WeenatPlotSensorData with _$WeenatPlotSensorData {
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

  /// Translates entity class to model class
  factory WeenatPlotSensorData.fromEntity(WeenatPlotSensorDataEntity? entity) {
    if (entity == null) return const WeenatPlotSensorData();

    return WeenatPlotSensorData(
      id: entity.id,
      sensorData: entity.sensorData,
      dataType: entity.dataType,
      timeStamp: entity.timeStamp,
      plotId: entity.plotId,
      sensorDataDepth: entity.sensorDataDepth,
    );
  }

  /// Translates model class data to entity needed for local database
  WeenatPlotSensorDataEntity toEntity() {
    return WeenatPlotSensorDataEntity()
      ..id = id
      ..sensorData = sensorData
      ..sensorDataDepth = sensorDataDepth
      ..dataType = dataType
      ..timeStamp = timeStamp
      ..plotId = plotId;
  }
}

extension WeenatPlotSensorsDataEx on List<WeenatPlotSensorData> {
  /// Translates a list of [WeenatPlotSensorData] to list of [WeenatPlotSensorDataEntity]
  List<WeenatPlotSensorDataEntity> toEntities() {
    return map((e) => e.toEntity()).toList();
  }
}

extension WeenatPlotSensorDataEntitiesEx on List<WeenatPlotSensorDataEntity> {
  /// Translates a list of [WeenatPlotSensorDataEntity] to a list of [WeenatPlotSensorData]
  List<WeenatPlotSensorData> toModels() {
    return map((e) => WeenatPlotSensorData.fromEntity(e)).toList();
  }
}
