// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:irrigazione_iot/src/config/enums/weenat_sensor_data_types.dart';
// import 'package:irrigazione_iot/src/data/datasource/entities/weenat_plot_sensor_data_entity.dart';

// part 'weenat_plot_sensor_data.freezed.dart';
// part 'weenat_plot_sensor_data.g.dart';

// /// A class representation of data needed to plot sensor data
// @freezed
// class WeenatPlotSensorData with _$WeenatPlotSensorData {
//   static const sensorDataKey = 'sensorData';
//   static const dataTypeKey = 'dataType';
//   static const sensorDataDepthKey = 'sensorDataDepth';
//   static const timeStampKey = 'timeStamp';
//   static const plotIdKey = 'plotId';
//   static const idKey = 'id';

//   const WeenatPlotSensorData._();

//   const factory WeenatPlotSensorData({
//     /// Primarily local database data id
//     int? id,

//     /// Temperature (°C)
//     @JsonKey(name: 'T') double? temperature,

//     /// Relative humidity (%)
//     @JsonKey(name: 'U') double? relativeHumidity,

//     /// Cumulative rainfall (mm)
//     @JsonKey(name: 'RR') double? cumulativeRainfall,

//     /// Wind speed
//     @JsonKey(name: 'FF') double? windSpeed,

//     /// The related sensor data, which could be soil temperature
//     /// or water potential at different depths
//     @JsonKey(name: 'sensorData') double? sensorData,

//     /// The depth at which the sensor data is associated with
//     @JsonKey(name: 'sensorDataDepth') double? sensorDataDepth,

//     /// The type of sensor data
//     @JsonKey(name: 'dataType') WeenatSensorDataType? dataType,

//     /// Dry temperature (°C)
//     @JsonKey(name: 'T_DRY') double? dryTemperature,

//     /// Wet temperature
//     @JsonKey(name: 'T_WET') double? wetTemperature,

//     /// Leaf wetness duration
//     @JsonKey(name: 'LW_D') double? leafWetnessDuration,

//     /// Leaf wetness voltage
//     @JsonKey(name: 'LW_V') double? leafWetnessVoltage,

//     /// Soil temperature
//     @JsonKey(name: 'T_SOIL') double? soilTemperature,

//     /// Solar irradiance
//     @JsonKey(name: 'SSI') double? solarIrradiance,

//     /// Minimum solar irradiance
//     @JsonKey(name: 'SSI_MIN') double? minimumSolarIrradiance,

//     /// Maximum solar irradiance
//     @JsonKey(name: 'SSI_MAX') double? maximumSolarIrradiance,

//     /// Dew point
//     @JsonKey(name: 'T_DEW') double? dewPoint,

//     /// Potential evapotranspiration
//     @JsonKey(name: 'etp') potentialEtp,

//     /// The timestamp of when this data was registered
//     DateTime? timeStamp,

//     /// The id of the plot to which this data belongs to
//     int? plotId,
//   }) = _WeenatPlotSensorData;

//   factory WeenatPlotSensorData.fromJson(Map<String, dynamic> json) =>
//       _$WeenatPlotSensorDataFromJson(json);

//   /// Translates entity class to model class
//   factory WeenatPlotSensorData.fromEntity(WeenatPlotSensorDataEntity? entity) {
//     if (entity == null) return const WeenatPlotSensorData();

//     return WeenatPlotSensorData(
//       id: entity.id,
//       temperature: entity.temperature,
//       relativeHumidity: entity.relativeHumidity,
//       cumulativeRainfall: entity.cumulativeRainfall,
//       windSpeed: entity.windSpeed,
//       sensorData: entity.sensorData,
//       dataType: entity.dataType,
//       dryTemperature: entity.dryTemperature,
//       wetTemperature: entity.wetTemperature,
//       leafWetnessDuration: entity.leafWetnessDuration,
//       leafWetnessVoltage: entity.leafWetnessVoltage,
//       soilTemperature: entity.soilTemperature,
//       solarIrradiance: entity.solarIrradiance,
//       minimumSolarIrradiance: entity.minimumSolarIrradiance,
//       maximumSolarIrradiance: entity.maximumSolarIrradiance,
//       dewPoint: entity.dewPoint,
//       potentialEtp: entity.potentialEtp,
//       timeStamp: entity.timeStamp,
//       plotId: entity.plotId,
//       sensorDataDepth: entity.sensorDataDepth,
//     );
//   }

//   /// Translates model class data to entity needed for local database
//   WeenatPlotSensorDataEntity toEntity() {
//     return WeenatPlotSensorDataEntity()
//       ..id = id
//       ..temperature = temperature
//       ..relativeHumidity = relativeHumidity
//       ..cumulativeRainfall = cumulativeRainfall
//       ..windSpeed = windSpeed
//       ..sensorData = sensorData
//       ..sensorDataDepth = sensorDataDepth
//       ..dataType = dataType
//       ..dryTemperature = dryTemperature
//       ..wetTemperature = wetTemperature
//       ..leafWetnessDuration = leafWetnessDuration
//       ..soilTemperature = soilTemperature
//       ..solarIrradiance = solarIrradiance
//       ..minimumSolarIrradiance = minimumSolarIrradiance
//       ..maximumSolarIrradiance = maximumSolarIrradiance
//       ..dewPoint = dewPoint
//       ..potentialEtp = potentialEtp
//       ..timeStamp = timeStamp
//       ..plotId = plotId;
//   }
// }

// extension WeenatPlotSensorsDataEx on List<WeenatPlotSensorData> {
//   /// Translates a list of [WeenatPlotSensorData] to list of [WeenatPlotSensorDataEntity]
//   List<WeenatPlotSensorDataEntity> toEntities() {
//     return map((e) => e.toEntity()).toList();
//   }
// }

// extension WeenatPlotSensorDataEntitiesEx on List<WeenatPlotSensorDataEntity> {
//   /// Translates a list of [WeenatPlotSensorDataEntity] to a list of [WeenatPlotSensorData]
//   List<WeenatPlotSensorData> toModels() {
//     return map((e) => WeenatPlotSensorData.fromEntity(e)).toList();
//   }
// }
