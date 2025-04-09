import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_database_keys.dart';
import 'package:irrigazione_iot/src/shared/models/db_cud_bodies.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseWeatherStationRepository implements WeatherStationRepository {
  const SupabaseWeatherStationRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  List<WeatherStation>? _fromJsonList(List<Map<String, dynamic>> data) {
    return data.map((weatherStation) => WeatherStation.fromJson(weatherStation)).toList();
  }

  WeatherStation? _toWeatherStation(Map<String, dynamic>? data) {
    return data == null ? null : WeatherStation.fromJson(data);
  }

  @override
  Future<WeatherStation?> createWeatherStation(WeatherStation weatherStation) async {
    final data = weatherStation.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now()).toJson();
    final res = await _supabaseClient.invokeFunction(
      functionName: 'insert-weather-station',
      body: InsertBody(data: data).toJson(),
    );
    return res.toObject<WeatherStation>(WeatherStation.fromJson);
  }

  @override
  Future<WeatherStation?> updateWeatherStation(WeatherStation weatherStation) async {
    final data = weatherStation.copyWith(updatedAt: DateTime.now()).toJson();
    final res = await _supabaseClient.invokeFunction(
      functionName: 'update-weather-station',
      body: UpdateBody(id: weatherStation.id, data: data).toJson(),
    );
    return res.toObject<WeatherStation>(WeatherStation.fromJson);
  }

  @override
  Future<bool> deleteWeatherStation(String weatherStationId) async {
    final res = await _supabaseClient.invokeFunction(
      functionName: 'delete-weather-station',
      body: DeleteBody(ids: [weatherStationId]).toJson(),
    );
    return res.onDelete;
  }

  @override
  Future<WeatherStation?> getWeatherStation(String id) async {
    final data = await _supabaseClient.weatherStations
        .select()
        .eq(WeatherStationDatabaseKeys.id, id)
        .maybeSingle()
        .withConverter(_toWeatherStation);

    return data;
  }

  @override
  Future<List<WeatherStation>?> getWeatherStations({required String companyId}) async {
    final data = await _supabaseClient.weatherStations
        .select()
        .eq(WeatherStationDatabaseKeys.companyId, companyId)
        .withConverter(_fromJsonList);

    return data;
  }

  @override
  Future<List<String>?> getUsedWeatherStationNames() async {
    final stations = await getAllWeatherStations();
    return stations?.map((station) => station.name.toLowerCase()).toList();
  }

  @override
  Future<List<String>?> getUsedWeatherStationEUIs() async {
    final stations = await getAllWeatherStations();
    return stations?.map((station) => station.eui.toLowerCase()).toList();
  }

  @override
  Future<int> getWeatherStationsCount(String sectorId) async {
    final sectorStations = await _supabaseClient.weatherStations
        .select()
        .eq(WeatherStationDatabaseKeys.sectorId, sectorId)
        .withConverter(_fromJsonList);

    return sectorStations?.length ?? 0;
  }

  @override
  Future<List<WeatherStation>?> getAllWeatherStations() async {
    final data = await _supabaseClient.weatherStations.select().withConverter(_fromJsonList);

    return data;
  }
}
