import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_battery_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'weather_station_battery.g.dart';

@JsonSerializable()
class WeatherStationBattery extends Equatable {
  const WeatherStationBattery({
    required this.id,
    required this.batteryLevel,
    required this.weatherStationId,
    this.createdAt,
  });

  const WeatherStationBattery.empty()
      : id = '',
        batteryLevel = 0,
        weatherStationId = '',
        createdAt = null;

  @JsonKey(name: WeatherStationBatteryDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: WeatherStationBatteryDatabaseKeys.batteryLevel)
  final num batteryLevel;

  @JsonKey(name: WeatherStationBatteryDatabaseKeys.weatherStationId)
  @IntConverter()
  final String weatherStationId;

  @JsonKey(name: WeatherStationBatteryDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props {
    return [
      id,
      batteryLevel,
      weatherStationId,
      createdAt,
    ];
  }

  factory WeatherStationBattery.fromJson(Map<String, dynamic> json) =>
      _$WeatherStationBatteryFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherStationBatteryToJson(this);
}
