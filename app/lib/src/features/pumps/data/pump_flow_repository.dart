import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/supabase_pump_flow_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'pump_flow_repository.g.dart';

abstract class PumpFlowRepository {
  Stream<int> watchTotalLitresDispensed(Pump pump);
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
  final pump = ref.watch(pumpStreamProvider(pumpId)).valueOrNull;
  if (pump == null) return Stream.value(0);
  return pumpDetailsRepository.watchTotalLitresDispensed(pump);
}
