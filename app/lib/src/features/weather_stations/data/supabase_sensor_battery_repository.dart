import 'package:irrigazione_iot/src/features/weather_stations/data/sensor_battery_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_battery.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_battery_database_keys.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSensorBatteryRepository implements SensorBatteryRepository {
  const SupabaseSensorBatteryRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Stream<WeatherStationBattery?> lastSensorBatteryStream(String sensorId) {
    return _supabaseClient.sensorBatteryData
        .stream(primaryKey: [WeatherStationBatteryDatabaseKeys.id])
        .eq(WeatherStationBatteryDatabaseKeys.weatherStationId, sensorId)
        .order(WeatherStationBatteryDatabaseKeys.createdAt, ascending: false)
        .limit(1)
        .map(
          (data) => data.isEmpty
              ? null
              : WeatherStationBattery.fromJson(
                  data.first,
                ),
        );
  }
}
