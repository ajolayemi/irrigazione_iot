import 'package:irrigazione_iot/src/features/weather_stations/data/sensor_measurement_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/sensor_measurements.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/sensor_measurements_database_keys.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSensorMeasurementRepository
    implements SensorMeasurementRepository {
  const SupabaseSensorMeasurementRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;
  @override
  Stream<SensorMeasurement?> sensorMeasurementStream(String sensorId) {
    return _supabaseClient.sensorMeasurements
        .stream(primaryKey: [SensorMeasurementsDatabaseKeys.id])
        .eq(SensorMeasurementsDatabaseKeys.sensorId, sensorId)
        .order(SensorMeasurementsDatabaseKeys.createdAt, ascending: false)
        .limit(1)
        .map((data) =>
            data.isNotEmpty ? SensorMeasurement.fromJson(data.first) : null);
  }
}
