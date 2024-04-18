import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/pumps/data/supabase_pump_flow_repository.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'pump_flow_repository.g.dart';

abstract class PumpFlowRepository {
  /// Emits the total litres dispensed by the pump with the provided [pumpId]
  Stream<int> watchTotalLitresDispensed(String pumpId);
}

@Riverpod(keepAlive: true)
PumpFlowRepository pumpFlowRepository(PumpFlowRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabasePumpFlowRepository(supabaseClient);
}

@riverpod
Stream<int> pumpTotalDispensedLitres(
    PumpTotalDispensedLitresRef ref, String pumpId) {
  final pumpDetailsRepository = ref.watch(pumpFlowRepositoryProvider);
  return pumpDetailsRepository.watchTotalLitresDispensed(pumpId);
}
