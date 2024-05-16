import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_battery_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_battery.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_battery_database_keys.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseWeatherStationBatteryRepository
    implements WeatherStationBatteryRepository {
  const SupabaseWeatherStationBatteryRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  WeatherStationBattery? _fromData(List<Map<String, dynamic>> data) =>
      data.isEmpty ? null : WeatherStationBattery.fromJson(data.first);

  @override
  Stream<WeatherStationBattery?> lastWeatherStationBatteryStream(
      String weatherStationId) {
    return _supabaseClient.weatherStationBatteryData
        .stream(primaryKey: [WeatherStationBatteryDatabaseKeys.id])
        .eq(WeatherStationBatteryDatabaseKeys.weatherStationId,
            weatherStationId)
        .order(WeatherStationBatteryDatabaseKeys.createdAt, ascending: false)
        .limit(1)
        .map(_fromData);
  }
}
