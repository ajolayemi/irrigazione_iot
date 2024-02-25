import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_details_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump_details.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pump_details_repository.g.dart';

abstract class PumpDetailsRepository {
  Future<PumpDetails?> getPumpDetails(Pump pump);
  Stream<PumpDetails?> watchPumpDetails(Pump pump);
}

@Riverpod(keepAlive: true)
PumpDetailsRepository pumpDetailsRepository(PumpDetailsRepositoryRef ref) {
  return FakePumpDetailsRepository(); // todo replace with real implementation
}

@riverpod
Future<PumpDetails?> pumpDetailsFuture(
    PumpDetailsFutureRef ref, String pumpId) {
  final pump = ref.watch(pumpFutureProvider(pumpId)).value;
  if (pump == null) return Future.value(null);
  final pumpDetailsRepository = ref.watch(pumpDetailsRepositoryProvider);
  return pumpDetailsRepository.getPumpDetails(pump);
}

@riverpod
Stream<PumpDetails?> pumpDetailsStream(
    PumpDetailsStreamRef ref, String pumpId) {
  final pumpDetailsRepository = ref.watch(pumpDetailsRepositoryProvider);
  final pump = ref.watch(pumpStreamProvider(pumpId)).value; 
  if (pump == null) return const Stream.empty();
  return pumpDetailsRepository.watchPumpDetails(pump);
}
