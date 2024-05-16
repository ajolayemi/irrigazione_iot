import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_statistic_history.dart';
import 'package:irrigazione_iot/src/features/weather_stations/data/supabase_weather_station_statistic_history_repository.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_station_statistic_history_repository.g.dart';

abstract class WeatherStationStatisticHistoryRepository {
  /// Emits a list of [WeatherStationStatisticHistory] for the given [weatherStationId].
  /// The list is sorted in descending order of [WeatherStationStatisticHistory.createdAt].
  /// The list is limited to [limit] elements.
  Future<List<WeatherStationStatisticHistory>?> weatherStationStatisticsStream(
    String weatherStationId,
    String colName, {
    int limit = 30,
  });
}

@Riverpod(keepAlive: true)
WeatherStationStatisticHistoryRepository
    weatherStationStatisticHistoryRepository(
        WeatherStationStatisticHistoryRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseWeatherStationStatisticHistoryRepository(supabaseClient);
}

@riverpod
Future<List<WeatherStationStatisticHistory>?> weatherStationStatisticsFuture(
  WeatherStationStatisticsFutureRef ref,
  String weatherStationId,
  String colName, {
  int limit = 30,
}) {
  final repo = ref.watch(weatherStationStatisticHistoryRepositoryProvider);
  return repo.weatherStationStatisticsStream(weatherStationId, colName, limit: limit);
}
