import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_statistic_history_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_measurements_database_keys.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_statistic_history.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseWeatherStationStatisticHistoryRepository
    implements WeatherStationStatisticHistoryRepository {
  const SupabaseWeatherStationStatisticHistoryRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  String get _createdAt => WeatherStationMeasurementsDatabaseKeys.createdAt;
  String get _weatherStationId =>
      WeatherStationMeasurementsDatabaseKeys.weatherStationId;

  List<WeatherStationStatisticHistory> _convert(
    List<Map<String, dynamic>> data,
    String colName,
  ) {
    return data
        .map((e) => WeatherStationStatisticHistory(
              value: e[colName] as num,
              createdAt: DateTime.parse(e[_createdAt] as String),
            ))
        .toList();
  }

  @override
  Future<List<WeatherStationStatisticHistory>?> weatherStationStatisticsStream(
    String weatherStationId,
    String colName, {
    int limit = 30,
  }) {
    return _supabaseClient.weatherStationMeasurements
        .select('$colName, $_createdAt')
        .eq(_weatherStationId, weatherStationId)
        .order(_createdAt, ascending: false)
        .limit(limit)
        .withConverter((data) => _convert(data, colName));
  }
}
