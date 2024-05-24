import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/pumps/data/supabase_pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status.dart';
import 'package:irrigazione_iot/src/shared/models/item_status_request.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';
import 'package:irrigazione_iot/src/shared/services/mqtt_client_service.dart';

part 'pump_status_repository.g.dart';

abstract class PumpStatusRepository {
  /// Emits the status of the pump with the provided [pumpId]
  /// The real pump status is a string value that will be converted to a boolean value
  Stream<PumpStatus?> watchPumpStatus(String pumpId);

  /// Toggles the status of a pump
  Future<void> togglePumpStatus({
    required ItemStatusRequest statusBody,
  });
}

@Riverpod(keepAlive: true)
PumpStatusRepository pumpStatusRepository(PumpStatusRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  final mqttClient = ref.watch(mqttClientServiceProvider);

  return SupabasePumpStatusRepository(
    supabaseClient,
    mqttClient,
  );
}

/// Emits the status of the pump with the provided [pumpId]
@riverpod
Stream<PumpStatus?> pumpStatusStream(PumpStatusStreamRef ref, String pumpId) {
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.watchPumpStatus(pumpId);
}
