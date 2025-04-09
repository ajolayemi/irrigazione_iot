import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/weather_stations/data/supabase_weather_station_battery_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_battery.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'weather_station_battery_repository.g.dart';

abstract class WeatherStationBatteryRepository {
  /// Returns the last [WeatherStationBattery] data for the given [weatherStationId]
  Future<WeatherStationBattery?> getLastWeatherStationBattery(
    String weatherStationId,
  );
}

@Riverpod(keepAlive: true)
WeatherStationBatteryRepository weatherStationBatteryRepository(Ref ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseWeatherStationBatteryRepository(supabaseClient);
}

/// Holds onto the most recent [WeatherStationBattery] for a weather station
/// It auto updates at a set interval
@Riverpod(keepAlive: true)
FutureOr<WeatherStationBattery?> weatherStationBattery(
  Ref ref, {
  required String weatherStationId,
}) {
  final timer = Timer.periodic(
    AppConstants.weatherStationBatteryUpdateInterval,
    (_) {
      ref.invalidateSelf();
    },
  );

  ref.onDispose(() {
    timer.cancel();
  });
  final repo = ref.watch(weatherStationBatteryRepositoryProvider);
  return repo.getLastWeatherStationBattery(weatherStationId);
}
