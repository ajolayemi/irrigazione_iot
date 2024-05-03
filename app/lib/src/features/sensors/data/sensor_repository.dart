import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/sensors/data/supabase_sensor_repository.dart';
import 'package:irrigazione_iot/src/features/sensors/model/sensor.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'sensor_repository.g.dart';

abstract class SensorRepository {
  /// Creates a new [Sensor].
  Future<Sensor?> createSensor(Sensor sensor);

  /// Updates an existing [Sensor].
  Future<Sensor?> updateSensor(Sensor sensor);

  /// Deletes an existing [Sensor].
  Future<bool> deleteSensor(Sensor sensor);

  /// Emits all available [Sensor]s for the given [companyId].
  Stream<List<Sensor>?> watchSensors(String companyId);

  /// Emits the [Sensor] with the given [id].
  Stream<Sensor?> watchSensor(String id);

  /// Emits a list of already used sensor names.
  /// This is used in form validation to prevent duplicate sensor names.
  Stream<List<String?>> watchUsedSensorNames();
}

@Riverpod(keepAlive: true)
SensorRepository sensorRepository(SensorRepositoryRef ref) {
  final supabaseClient = ref.read(supabaseClientProvider);
  return SupabaseSensorRepository(supabaseClient);
}

@riverpod
Stream<Sensor?> sensorStream(SensorStreamRef ref, String id) {
  final sensorRepo = ref.watch(sensorRepositoryProvider);
  return sensorRepo.watchSensor(id);
}

@riverpod
Stream<List<Sensor>?> sensorsStream(SensorsStreamRef ref) {
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return Stream.value([]);
  final sensorRepo = ref.watch(sensorRepositoryProvider);
  return sensorRepo.watchSensors(companyId);
}

@riverpod
Stream<List<String?>> usedSensorNamesStream(UsedSensorNamesStreamRef ref) {
  final sensorRepo = ref.watch(sensorRepositoryProvider);
  return sensorRepo.watchUsedSensorNames();
}