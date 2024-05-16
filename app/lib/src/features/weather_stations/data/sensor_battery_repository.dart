import 'package:irrigazione_iot/src/features/weather_stations/data/supabase_sensor_battery_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_battery.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sensor_battery_repository.g.dart';

abstract class SensorBatteryRepository {
  /// emits the last [WeatherStationBattery] data for the given [sensorId]
  Stream<WeatherStationBattery?> lastSensorBatteryStream(String sensorId);
}

@Riverpod(keepAlive: true)
SensorBatteryRepository sensorBatteryRepository(
    SensorBatteryRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseSensorBatteryRepository(supabaseClient);
}

@riverpod
Stream<WeatherStationBattery?> lastSensorBatteryStream(
    LastSensorBatteryStreamRef ref, String sensorId) {
  final repo = ref.watch(sensorBatteryRepositoryProvider);
  return repo.lastSensorBatteryStream(sensorId);
}
