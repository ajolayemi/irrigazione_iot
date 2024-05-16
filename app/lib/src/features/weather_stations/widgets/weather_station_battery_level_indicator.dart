import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/battery_level_indicator.dart';
import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_battery_repository.dart';

class WeatherStationBatteryLevelIndicator extends ConsumerWidget {
  const WeatherStationBatteryLevelIndicator({
    super.key,
    required this.weatherStationId,
  });

  final String weatherStationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherStationBatteryLevel = ref
        .watch(lastWeatherStationBatteryStreamProvider(weatherStationId))
        .valueOrNull;
    final batteryLevel = (weatherStationBatteryLevel?.batteryLevel ?? 0.0);
    return BatteryLevelIndicator(
      batteryLevel: batteryLevel.toDouble(),
    );
  }
}
