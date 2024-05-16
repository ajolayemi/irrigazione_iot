import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_measurement_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_measurement.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_measurements_database_keys.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseWeatherStationMeasurementRepository
    implements WeatherStationMeasurementRepository {
  const SupabaseWeatherStationMeasurementRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  WeatherStationMeasurement? _fromData(List<Map<String, dynamic>> data) =>
      data.isNotEmpty ? WeatherStationMeasurement.fromJson(data.first) : null;

  @override
  Stream<WeatherStationMeasurement?> weatherStationMeasurementStream(
      String weatherStationId) {
    return _supabaseClient.weatherStationMeasurements
        .stream(primaryKey: [WeatherStationMeasurementsDatabaseKeys.id])
        .eq(
          WeatherStationMeasurementsDatabaseKeys.weatherStationId,
          weatherStationId,
        )
        .order(
          WeatherStationMeasurementsDatabaseKeys.createdAt,
          ascending: false,
        )
        .limit(1)
        .map(_fromData);
  }
}
