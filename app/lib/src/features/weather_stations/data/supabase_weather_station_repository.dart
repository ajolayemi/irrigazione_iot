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
    return data
        .map(
          (weatherStation) => WeatherStation.fromJson(weatherStation),
        )
        .toList();
  }

  WeatherStation? _fromJsonSingle(List<Map<String, dynamic>> data) {
    return data.isEmpty ? null : WeatherStation.fromJson(data.first);
  }

  @override
  Future<WeatherStation?> createWeatherStation(
      WeatherStation weatherStation) async {
    final data = weatherStation
        .copyWith(
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )
        .toJson();
    final res = await _supabaseClient.invokeFunction(
      functionName: 'insert-weather-station',
      body: InsertBody(data: data).toJson(),
    );
    return res.toObject<WeatherStation>(WeatherStation.fromJson);
  }

  @override
  Future<WeatherStation?> updateWeatherStation(
      WeatherStation weatherStation) async {
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
  Stream<WeatherStation?> watchWeatherStation(String id) {
    final stream = _supabaseClient.weatherStationStream
        .eq(WeatherStationDatabaseKeys.id, id);

    return stream.map(_fromJsonSingle);
  }

  @override
  Stream<List<WeatherStation>?> watchWeatherStations(String companyId) {
    final stream = _supabaseClient.weatherStationStream
        .eq(WeatherStationDatabaseKeys.companyId, companyId);

    return stream.map(_fromJsonList);
  }

  @override
  Stream<List<String?>> watchUsedWeatherStationNames() {
    return _supabaseClient.weatherStationStream.map((data) {
      return data
          .map((data) =>
              data[WeatherStationDatabaseKeys.name].toString().toLowerCase())
          .toList();
    });
  }

  @override
  Stream<List<String?>> watchUsedWeatherStationEUIs() {
    return _supabaseClient.weatherStationStream.map((data) {
      return data
          .map((weatherStation) =>
              weatherStation[WeatherStationDatabaseKeys.eui].toString().toLowerCase())
          .toList();
    });
  }

  @override
  Stream<int> watchWeatherStationsCount(String sectorId) {
    final stream = _supabaseClient.weatherStationStream
        .eq(WeatherStationDatabaseKeys.sectorId, sectorId);

    return stream.map((data) => data.length);
  }
}
