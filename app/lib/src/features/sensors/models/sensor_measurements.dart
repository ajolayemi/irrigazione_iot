// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/sensors/models/sensor_measurements_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'sensor_measurements.g.dart';

@JsonSerializable()
class SensorMeasurement extends Equatable {
  const SensorMeasurement({
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

  const SensorMeasurement.empty()
      : id = '',
        airTemperature = 0,
        airHumidity = 0,
        lightIntensity = 0,
        uvIndex = 0,
        windSpeed = 0,
        windDirection = 0,
        rainGauge = 0,
        barometricPressure = 0,
        createdAt = null,
        sensorId = '';

  @JsonKey(name: SensorMeasurementsDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.airTemperature)
  final num airTemperature;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.airHumidity)
  final num airHumidity;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.lightIntensity)
  final num lightIntensity;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.uvIndex)
  final num uvIndex;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.windSpeed)
  final num windSpeed;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.windDirection)
  final num windDirection;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.rainGauge)
  final num rainGauge;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.barometricPressure)
  final num barometricPressure;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @JsonKey(name: SensorMeasurementsDatabaseKeys.sensorId)
  @IntConverter()
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

  factory SensorMeasurement.fromJson(Map<String, dynamic> json) =>
      _$SensorMeasurementFromJson(json);

  Map<String, dynamic> toJson() => _$SensorMeasurementToJson(this);
}
