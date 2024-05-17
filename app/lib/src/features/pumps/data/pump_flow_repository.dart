import 'package:irrigazione_iot/src/features/pumps/models/pump_flow.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/pumps/data/supabase_pump_flow_repository.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'pump_flow_repository.g.dart';

abstract class PumpFlowRepository {
  /// Emits the total litres dispensed by the pump with the provided [pumpId]
  Stream<int> watchTotalLitresDispensed(String pumpId);

  /// Emits the last time the pump with the provided [pumpId] dispensed water
  Stream<DateTime?> watchLastDispensation(String pumpId);

  /// Emits the last [PumpFlow] of the pump with the provided [pumpId]
  Stream<PumpFlow?> watchPumpLastFlow(String pumpId);
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

@riverpod
Stream<DateTime?> lastDispensationStream(
    LastDispensationStreamRef ref, String pumpId) {
  final pumpDetailsRepository = ref.watch(pumpFlowRepositoryProvider);
  return pumpDetailsRepository.watchLastDispensation(pumpId);
}

@riverpod
Stream<PumpFlow?> pumpLastFlowStream(PumpLastFlowStreamRef ref, String pumpId) {
  final pumpDetailsRepository = ref.watch(pumpFlowRepositoryProvider);
  return pumpDetailsRepository.watchPumpLastFlow(pumpId);
}