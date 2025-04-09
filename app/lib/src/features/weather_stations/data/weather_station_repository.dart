// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
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

  /// Returns all available [WeatherStation]s for the given [companyId].
  Future<List<WeatherStation>?> getWeatherStations({required String companyId});

  /// Fetches the [WeatherStation] with the given [id].
  Future<WeatherStation?> getWeatherStation(String id);

  /// Gets a general list of all available [WeatherStation]s.
  Future<List<WeatherStation>?> getAllWeatherStations();

  /// Returns a list of already used weather station names.
  /// This is used in form validation to prevent duplicate weather station names.
  Future<List<String>?> getUsedWeatherStationNames();

  /// Returns the list of already registered weather station EUIs.
  /// This is used in form validation to prevent duplicate weather station EUIs.
  Future<List<String>?> getUsedWeatherStationEUIs();

  /// Emits the number of weather stations connected to the provided [sectorId]
  Future<int> getWeatherStationsCount(String sectorId);
}

@Riverpod(keepAlive: true)
WeatherStationRepository weatherStationRepository(
    Ref ref) {
  final supabaseClient = ref.read(supabaseClientProvider);
  return SupabaseWeatherStationRepository(supabaseClient);
}

@riverpod
Future<WeatherStation?> weatherStation(
  Ref ref,
  String id,
) {
  final sensorRepo = ref.watch(weatherStationRepositoryProvider);
  return sensorRepo.getWeatherStation(id);
}

@riverpod
FutureOr<List<WeatherStation>?> weatherStations(Ref ref) {
  final companyId = ref.watch(tappedCompanyIdProvider).valueOrNull;
  if (companyId == null) return null;
  final repo = ref.watch(weatherStationRepositoryProvider);
  return repo.getWeatherStations(companyId: companyId);
}

@Riverpod(keepAlive: true)
FutureOr<List<String>?> usedWeatherStationsNames(
  Ref ref,
) {
  final repo = ref.watch(weatherStationRepositoryProvider);
  return repo.getUsedWeatherStationNames();
}

@Riverpod(keepAlive: true)
FutureOr<List<String>?> usedWeatherStationEUIs(Ref ref) {
  final repo = ref.watch(weatherStationRepositoryProvider);
  return repo.getUsedWeatherStationEUIs();
}

@Riverpod(keepAlive: true)
FutureOr<int> weatherStationsCount(
  Ref ref,
  String sectorId,
) {
  final sensorRepo = ref.watch(weatherStationRepositoryProvider);
  return sensorRepo.getWeatherStationsCount(sectorId);
}

