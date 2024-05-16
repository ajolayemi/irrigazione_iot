import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/weather_stations/data/supabase_sensor_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'sensor_repository.g.dart';

abstract class SensorRepository {
  /// Creates a new [WeatherStation].
  Future<WeatherStation?> createSensor(WeatherStation sensor);

  /// Updates an existing [WeatherStation].
  Future<WeatherStation?> updateSensor(WeatherStation sensor);

  /// Deletes an existing [WeatherStation].
  Future<bool> deleteSensor(String sensorId);

  /// Emits all available [WeatherStation]s for the given [companyId].
  Stream<List<WeatherStation>?> watchSensors(String companyId);

  /// Emits the [WeatherStation] with the given [id].
  Stream<WeatherStation?> watchSensor(String id);

  /// Emits a list of already used sensor names.
  /// This is used in form validation to prevent duplicate sensor names.
  Stream<List<String?>> watchUsedSensorNames();

  /// Emits the list of already registered sensor EUIs.
  /// This is used in form validation to prevent duplicate sensor EUIs.
  Stream<List<String?>> watchUsedSensorEUIs();

  /// Emits the number of sensors connected to the provided [sectorId]
  Stream<int> watchSensorsCount(String sectorId);
}

@Riverpod(keepAlive: true)
SensorRepository sensorRepository(SensorRepositoryRef ref) {
  final supabaseClient = ref.read(supabaseClientProvider);
  return SupabaseSensorRepository(supabaseClient);
}

@riverpod
Stream<WeatherStation?> sensorStream(SensorStreamRef ref, String id) {
  final sensorRepo = ref.watch(sensorRepositoryProvider);
  return sensorRepo.watchSensor(id);
}

@riverpod
Stream<List<WeatherStation>?> sensorsStream(SensorsStreamRef ref) {
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

@riverpod
Stream<List<String?>> usedSensorEUIsStream(UsedSensorEUIsStreamRef ref) {
  final sensorRepo = ref.watch(sensorRepositoryProvider);
  return sensorRepo.watchUsedSensorEUIs();
}

@riverpod
Stream<int> sensorsCountStream(SensorsCountStreamRef ref, String sectorId) {
  final sensorRepo = ref.watch(sensorRepositoryProvider);
  return sensorRepo.watchSensorsCount(sectorId);
}
