import 'package:irrigazione_iot/src/features/weather_stations/data/sensor_measurement_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_measurement.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_measurements_database_keys.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSensorMeasurementRepository
    implements SensorMeasurementRepository {
  const SupabaseSensorMeasurementRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;
  @override
  Stream<WeatherStationMeasurement?> sensorMeasurementStream(String sensorId) {
    return _supabaseClient.sensorMeasurements
        .stream(primaryKey: [WeatherStationMeasurementsDatabaseKeys.id])
        .eq(WeatherStationMeasurementsDatabaseKeys.weatherStationId, sensorId)
        .order(WeatherStationMeasurementsDatabaseKeys.createdAt,
            ascending: false)
        .limit(1)
        .map((data) => data.isNotEmpty
            ? WeatherStationMeasurement.fromJson(data.first)
            : null);
  }
}
