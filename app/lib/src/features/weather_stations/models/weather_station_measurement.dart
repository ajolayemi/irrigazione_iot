// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_measurements_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'weather_station_measurement.g.dart';

@JsonSerializable()
class WeatherStationMeasurement extends Equatable {
  const WeatherStationMeasurement({
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
    required this.weatherStationId,
  });

  const WeatherStationMeasurement.empty()
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
        weatherStationId = '';

  @JsonKey(
      name: WeatherStationMeasurementsDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: WeatherStationMeasurementsDatabaseKeys.airTemperature)
  final num airTemperature;

  @JsonKey(name: WeatherStationMeasurementsDatabaseKeys.airHumidity)
  final num airHumidity;

  @JsonKey(name: WeatherStationMeasurementsDatabaseKeys.lightIntensity)
  final num lightIntensity;

  @JsonKey(name: WeatherStationMeasurementsDatabaseKeys.uvIndex)
  final num uvIndex;

  @JsonKey(name: WeatherStationMeasurementsDatabaseKeys.windSpeed)
  final num windSpeed;

  @JsonKey(name: WeatherStationMeasurementsDatabaseKeys.windDirection)
  final num windDirection;

  @JsonKey(name: WeatherStationMeasurementsDatabaseKeys.rainGauge)
  final num rainGauge;

  @JsonKey(name: WeatherStationMeasurementsDatabaseKeys.barometricPressure)
  final num barometricPressure;

  @JsonKey(name: WeatherStationMeasurementsDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @JsonKey(name: WeatherStationMeasurementsDatabaseKeys.weatherStationId)
  @IntConverter()
  final String weatherStationId;

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
      weatherStationId,
    ];
  }

  factory WeatherStationMeasurement.fromJson(Map<String, dynamic> json) =>
      _$WeatherStationMeasurementFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherStationMeasurementToJson(this);
}
