import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/weather_stations/data/supabase_sensor_measurement_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_measurement.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'sensor_measurement_repository.g.dart';

abstract class SensorMeasurementRepository {
  /// Emits the last [WeatherStationMeasurement] for the given [sensorId].
  Stream<WeatherStationMeasurement?> sensorMeasurementStream(String sensorId);
}

@Riverpod(keepAlive: true)
SensorMeasurementRepository sensorMeasurementRepository(
    SensorMeasurementRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseSensorMeasurementRepository(supabaseClient);
}

@riverpod
Stream<WeatherStationMeasurement?> lastSensorMeasurementStream(
    LastSensorMeasurementStreamRef ref, String sensorId) {
  final repo = ref.watch(sensorMeasurementRepositoryProvider);
  return repo.sensorMeasurementStream(sensorId);
}
