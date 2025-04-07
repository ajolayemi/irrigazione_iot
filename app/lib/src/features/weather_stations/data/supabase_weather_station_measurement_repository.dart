import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_measurement_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_measurement.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_measurements_database_keys.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseWeatherStationMeasurementRepository
    implements WeatherStationMeasurementRepository {
  const SupabaseWeatherStationMeasurementRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<WeatherStationMeasurement?> getStationMeasurement(
    String weatherStationId,
  ) async {
    final data = await _supabaseClient.weatherStationMeasurements
        .select()
        .eq(
          WeatherStationMeasurementsDatabaseKeys.weatherStationId,
          weatherStationId,
        )
        .order(WeatherStationMeasurementsDatabaseKeys.createdAt,
            ascending: false)
        .limit(1)
        .maybeSingle();

    if (data == null) return null;

    return WeatherStationMeasurement.fromJson(data);
  }
}
