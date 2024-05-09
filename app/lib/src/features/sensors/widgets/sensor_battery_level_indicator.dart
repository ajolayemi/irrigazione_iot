import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/battery_level_indicator.dart';
import 'package:irrigazione_iot/src/features/sensors/data/sensor_battery_repository.dart';

class SensorBatteryLevelIndicator extends ConsumerWidget {
  const SensorBatteryLevelIndicator({
    super.key,
    required this.sensorId,
  });

  final String sensorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensorBatteryLevel =
        ref.watch(lastSensorBatteryStreamProvider(sensorId)).valueOrNull;
    final batteryLevel = (sensorBatteryLevel?.batteryLevel ?? 0.0);
    return BatteryLevelIndicator(
      batteryLevel: batteryLevel.toDouble(),
    );
  }
}
