// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/sensors/model/sensor_measurements_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'sensor_measurements.g.dart';

@JsonSerializable()
class SensorMeasurements extends Equatable {
  const SensorMeasurements({
    required this.id,
    required this.airTemperature,
    required this.airHumidity,
    required this.lightIntensity,
    required this.uvIndex,
    required this.windSpeed,
    required this.windDirection,
    required this.rainGauge,
    required this.barometricPressure,
    this.createdAt,
    required this.sensorId,
  });

  const SensorMeasurements.empty()
      : id = '',
        airTemperature = '',
        airHumidity = '',
        lightIntensity = '',
        uvIndex = '',
        windSpeed = '',
        windDirection = '',
        rainGauge = '',
        barometricPressure = '',
        createdAt = null,
        sensorId = '';

  @JsonKey(name: SensorMeasurementsDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.airTemperature)
  final String airTemperature;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.airHumidity)
  final String airHumidity;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.lightIntensity)
  final String lightIntensity;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.uvIndex)
  final String uvIndex;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.windSpeed)
  final String windSpeed;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.windDirection)
  final String windDirection;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.rainGauge)
  final String rainGauge;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.barometricPressure)
  final String barometricPressure;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.sensorId)
  final String sensorId;

  @override
  List<Object?> get props {
    return [
      id,
      airTemperature,
      airHumidity,
      lightIntensity,
      uvIndex,
      windSpeed,
      windDirection,
      rainGauge,
      barometricPressure,
      createdAt,
      sensorId,
    ];
  }

  factory SensorMeasurements.fromJson(Map<String, dynamic> json) =>
      _$SensorMeasurementsFromJson(json);

  Map<String, dynamic> toJson() => _$SensorMeasurementsToJson(this);
}
