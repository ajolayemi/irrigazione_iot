import 'package:irrigazione_iot/src/features/weather_stations/data/sensor_battery_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/sensor_battery.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/sensor_battery_database_keys.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSensorBatteryRepository implements SensorBatteryRepository {
  const SupabaseSensorBatteryRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Stream<SensorBattery?> lastSensorBatteryStream(String sensorId) {
    return _supabaseClient.sensorBatteryData
        .stream(primaryKey: [SensorBatteryDatabaseKeys.id])
        .eq(SensorBatteryDatabaseKeys.sensorId, sensorId)
        .order(SensorBatteryDatabaseKeys.createdAt, ascending: false)
        .limit(1)
        .map(
          (data) => data.isEmpty
              ? null
              : SensorBattery.fromJson(
                  data.first,
                ),
        );
  }
}
