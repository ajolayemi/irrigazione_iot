import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/pumps/data/supabase_pump_status_repository.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'pump_status_repository.g.dart';

abstract class PumpStatusRepository {
  /// Emits the status of the pump with the provided [pumpId]
  /// The real pump status is a string value that will be converted to a boolean value
  Stream<bool?> watchPumpStatus(String pumpId);

  /// Toggles the status of the pump with the provided [pumpId]
  Future<void> togglePumpStatus({
    required String pumpId,
    required String statusString,
    required bool statusBoolean,
  });
}

@Riverpod(keepAlive: true)
PumpStatusRepository pumpStatusRepository(PumpStatusRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabasePumpStatusRepository(supabaseClient);
}

/// Emits the status of the pump with the provided [pumpId]
@riverpod
Stream<bool?> pumpStatusStream(PumpStatusStreamRef ref, String pumpId) {
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.watchPumpStatus(pumpId);
}
