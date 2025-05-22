import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/data/datasource/dao/mqtt_dao.dart';
import 'package:irrigazione_iot/src/features/terminal/data/supabase_terminal_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/terminal/models/terminal_pressure.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'terminal_pressure_repository.g.dart';

abstract class TerminalPressureRepository {
  /// Emits the last [TerminalPressure] for the given terminal linked
  /// with the provided [collectorId]
  Stream<TerminalPressure?> watchTerminalPressure(String collectorId);

  Future<List<TerminalPressure>?> getLatestTerminalPressure();
}

@Riverpod(keepAlive: true)
TerminalPressureRepository terminalPressureRepository(
    TerminalPressureRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseTerminalPressureRepository(supabaseClient);
}

@riverpod
Stream<TerminalPressure?> terminalPressureStream(
  TerminalPressureStreamRef ref,
  String collectorId,
) {
  final mqttDao = ref.watch(mqttDaoProvider);
  return mqttDao.watchTerminalPressure(collectorId);
}
