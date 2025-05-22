import 'package:irrigazione_iot/src/data/datasource/dao/mqtt_dao.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/collectors/data/supabase_collector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector_pressure.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'collector_pressure_repository.g.dart';

abstract class CollectorPressureRepository {
  /// emits the most recent [CollectorPressure] if any for the collector with [collectorId]
  Stream<CollectorPressure?> watchCollectorPressure(String collectorId);

  Future<List<CollectorPressure>?> getLatestCollectorPressure();
}

@Riverpod(keepAlive: true)
CollectorPressureRepository collectorPressureRepository(
    CollectorPressureRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseCollectorPressureRepository(supabaseClient);
}

@riverpod
Stream<CollectorPressure?> collectorPressureStream(
  CollectorPressureStreamRef ref,
  String collectorId,
) {
  final mqttDao = ref.watch(mqttDaoProvider);
  return mqttDao.watchCollectorPressure(collectorId);
}
