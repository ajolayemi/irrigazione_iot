import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/weather_stations/data/supabase_weather_station_battery_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_battery.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'weather_station_battery_repository.g.dart';

abstract class WeatherStationBatteryRepository {
  /// emits the last [WeatherStationBattery] data for the given [weatherStationId]
  Stream<WeatherStationBattery?> lastWeatherStationBatteryStream(
      String weatherStationId);
}

@Riverpod(keepAlive: true)
WeatherStationBatteryRepository weatherStationBatteryRepository(
    WeatherStationBatteryRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseWeatherStationBatteryRepository(supabaseClient);
}

@riverpod
Stream<WeatherStationBattery?> lastWeatherStationBatteryStream(
    LastWeatherStationBatteryStreamRef ref, String weatherStationId) {
  final repo = ref.watch(weatherStationBatteryRepositoryProvider);
  return repo.lastWeatherStationBatteryStream(weatherStationId);
}
