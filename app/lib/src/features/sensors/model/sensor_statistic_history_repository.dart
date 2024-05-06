import 'package:irrigazione_iot/src/features/sensors/model/sensor_statistic_history.dart';
import 'package:irrigazione_iot/src/features/sensors/model/supabase_sensor_statistic_history_repository.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sensor_statistic_history_repository.g.dart';

abstract class SensorStatisticHistoryRepository {
  /// Emits a list of [SensorStatisticHistory] for the given [sensorId].
  /// The list is sorted in descending order of [SensorStatisticHistory.createdAt].
  /// The list is limited to [limit] elements.
  Future<List<SensorStatisticHistory>?> sensorStatisticsStream(
    String sensorId,
    String colName, {
    int limit = 30,
  });
}

@Riverpod(keepAlive: true)
SensorStatisticHistoryRepository sensorStatisticHistoryRepository(
    SensorStatisticHistoryRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseSensorStatisticHistoryRepository(supabaseClient);
}

@riverpod
Future<List<SensorStatisticHistory>?> sensorStatisticsFuture(
  SensorStatisticsFutureRef ref,
  String sensorId,
  String colName, {
  int limit = 30,
}) {
  final repo = ref.watch(sensorStatisticHistoryRepositoryProvider);
  return repo.sensorStatisticsStream(sensorId, colName, limit: limit);
}
