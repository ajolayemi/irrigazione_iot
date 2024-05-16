import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/weather_stations/data/supabase_weather_station_measurement_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_measurement.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'weather_station_measurement_repository.g.dart';

abstract class WeatherStationMeasurementRepository {
  /// Emits the last [WeatherStationMeasurement] for the given [weatherStationId].
  Stream<WeatherStationMeasurement?> weatherStationMeasurementStream(
    String weatherStationId,
  );
}

@Riverpod(keepAlive: true)
WeatherStationMeasurementRepository weatherStationMeasurementRepository(
    WeatherStationMeasurementRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseWeatherStationMeasurementRepository(supabaseClient);
}

@riverpod
Stream<WeatherStationMeasurement?> lastWeatherStationMeasurementStream(
    LastWeatherStationMeasurementStreamRef ref, String weatherStationId) {
  final repo = ref.watch(weatherStationMeasurementRepositoryProvider);
  return repo.weatherStationMeasurementStream(weatherStationId);
}
