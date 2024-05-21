import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/weather_stations/data/supabase_weather_station_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'weather_station_repository.g.dart';

abstract class WeatherStationRepository {
  /// Creates a new [WeatherStation].
  Future<WeatherStation?> createWeatherStation(WeatherStation weatherStation);

  /// Updates an existing [WeatherStation].
  Future<WeatherStation?> updateWeatherStation(WeatherStation weatherStation);

  /// Deletes an existing [WeatherStation].
  Future<bool> deleteWeatherStation(String weatherStationId);

  /// Emits all available [WeatherStation]s for the given [companyId].
  Stream<List<WeatherStation>?> watchWeatherStations(String companyId);

  /// Emits the [WeatherStation] with the given [id].
  Stream<WeatherStation?> watchWeatherStation(String id);

  /// Fetches the [WeatherStation] with the given [id].
  Future<WeatherStation?> getWeatherStation(String id);

  /// Emits a list of already used weather station names.
  /// This is used in form validation to prevent duplicate weather station names.
  Stream<List<String?>> watchUsedWeatherStationNames();

  /// Emits the list of already registered weather station EUIs.
  /// This is used in form validation to prevent duplicate weather station EUIs.
  Stream<List<String?>> watchUsedWeatherStationEUIs();

  /// Emits the number of weather stations connected to the provided [sectorId]
  Stream<int> watchWeatherStationsCount(String sectorId);
}

@Riverpod(keepAlive: true)
WeatherStationRepository weatherStationRepository(WeatherStationRepositoryRef ref) {
  final supabaseClient = ref.read(supabaseClientProvider);
  return SupabaseWeatherStationRepository(supabaseClient);
}

@riverpod
Stream<WeatherStation?> weatherStationStream(WeatherStationStreamRef ref, String id) {
  final sensorRepo = ref.watch(weatherStationRepositoryProvider);
  return sensorRepo.watchWeatherStation(id);
}

@riverpod
Future<WeatherStation?> weatherStationFuture(WeatherStationFutureRef ref, String id) {
  final sensorRepo = ref.watch(weatherStationRepositoryProvider);
  return sensorRepo.getWeatherStation(id);
}

@riverpod
Stream<List<WeatherStation>?> weatherStationsStream(WeatherStationsStreamRef ref) {
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return Stream.value([]);
  final sensorRepo = ref.watch(weatherStationRepositoryProvider);
  return sensorRepo.watchWeatherStations(companyId);
}

@riverpod
Stream<List<String?>> usedWeatherStationNamesStream(UsedWeatherStationNamesStreamRef ref) {
  final sensorRepo = ref.watch(weatherStationRepositoryProvider);
  return sensorRepo.watchUsedWeatherStationNames();
}

@riverpod
Stream<List<String?>> usedWeatherStationEUIsStream(UsedWeatherStationEUIsStreamRef ref) {
  final sensorRepo = ref.watch(weatherStationRepositoryProvider);
  return sensorRepo.watchUsedWeatherStationEUIs();
}

@riverpod
Stream<int> weatherStationsCountStream(WeatherStationsCountStreamRef ref, String sectorId) {
  final sensorRepo = ref.watch(weatherStationRepositoryProvider);
  return sensorRepo.watchWeatherStationsCount(sectorId);
}
