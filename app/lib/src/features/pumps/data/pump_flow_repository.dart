import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_details_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pump_flow_repository.g.dart';

// TODO do a complete refactor of this file

abstract class PumpFlowRepository {
  Stream<int> watchTotalLitresDispensed(Pump pump);
}

@Riverpod(keepAlive: true)
PumpFlowRepository pumpDetailsRepository(PumpDetailsRepositoryRef ref) {
  return FakePumpDetailsRepository(); // todo replace with real implementation
}

@riverpod
Stream<int> pumpTotalDispensedLitres(
    PumpTotalDispensedLitresRef ref, String pumpId) {
  final pumpDetailsRepository = ref.watch(pumpDetailsRepositoryProvider);
  final pump = ref.watch(pumpStreamProvider(pumpId)).valueOrNull;
  if (pump == null) return Stream.value(0);
  return pumpDetailsRepository.watchTotalLitresDispensed(pump);
}
