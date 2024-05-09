import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/sensors/data/supabase_sensor_measurement_repository.dart';
import 'package:irrigazione_iot/src/features/sensors/models/sensor_measurements.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'sensor_measurement_repository.g.dart';

abstract class SensorMeasurementRepository {
  /// Emits the last [SensorMeasurement] for the given [sensorId].
  Stream<SensorMeasurement?> sensorMeasurementStream(String sensorId);
}

@Riverpod(keepAlive: true)
SensorMeasurementRepository sensorMeasurementRepository(
    SensorMeasurementRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseSensorMeasurementRepository(supabaseClient);
}

@riverpod
Stream<SensorMeasurement?> lastSensorMeasurementStream(
    LastSensorMeasurementStreamRef ref, String sensorId) {
  final repo = ref.watch(sensorMeasurementRepositoryProvider);
  return repo.sensorMeasurementStream(sensorId);
}
