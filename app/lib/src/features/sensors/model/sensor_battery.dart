import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/sensors/model/sensor_battery_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'sensor_battery.g.dart';

@JsonSerializable()
class SensorBattery extends Equatable {
  const SensorBattery({
    required this.id,
    required this.batteryLevel,
    required this.sensorId,
    this.createdAt,
  });

  const SensorBattery.empty()
      : id = '',
        batteryLevel = 0,
        sensorId = '',
        createdAt = null;

  @JsonKey(name: SensorBatteryDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: SensorBatteryDatabaseKeys.batteryLevel)
  final num batteryLevel;

  @JsonKey(name: SensorBatteryDatabaseKeys.sensorId)
  @IntConverter()
  final String sensorId;

  @JsonKey(name: SensorBatteryDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props {
    return [
      id,
      batteryLevel,
      sensorId,
      createdAt,
    ];
  }

  factory SensorBattery.fromJson(Map<String, dynamic> json) =>
      _$SensorBatteryFromJson(json);

  Map<String, dynamic> toJson() => _$SensorBatteryToJson(this);
}
