import 'package:irrigazione_iot/src/features/sensors/data/supabase_sensor_battery_repository.dart';
import 'package:irrigazione_iot/src/features/sensors/model/sensor_battery.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sensor_battery_repository.g.dart';

abstract class SensorBatteryRepository {
  /// emits the last [SensorBattery] data for the given [sensorId]
  Stream<SensorBattery?> lastSensorBatteryStream(String sensorId);
}

@Riverpod(keepAlive: true)
SensorBatteryRepository sensorBatteryRepository(
    SensorBatteryRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseSensorBatteryRepository(supabaseClient);
}

@riverpod
Stream<SensorBattery?> lastSensorBatteryStream(
    LastSensorBatteryStreamRef ref, String sensorId) {
  final repo = ref.watch(sensorBatteryRepositoryProvider);
  return repo.lastSensorBatteryStream(sensorId);
}
