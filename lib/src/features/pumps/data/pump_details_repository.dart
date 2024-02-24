import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_details_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump_details.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pump_details_repository.g.dart';

abstract class PumpDetailsRepository {
  Future<PumpDetails?> getPumpDetails(String pumpId);
  Stream<PumpDetails?> watchPumpDetails(String pumpId);
}

@Riverpod(keepAlive: true)
PumpDetailsRepository pumpDetailsRepository (PumpDetailsRepositoryRef ref) {
  return FakePumpDetailsRepository(); // todo replace with real implementation
}

@riverpod
Future<PumpDetails?> pumpDetailsFuture (PumpDetailsFutureRef ref, String pumpId) {
  final pumpDetailsRepository = ref.watch(pumpDetailsRepositoryProvider);
  return pumpDetailsRepository.getPumpDetails(pumpId);  
}

@riverpod
Stream<PumpDetails?> pumpDetailsStream (PumpDetailsStreamRef ref, String pumpId) {
  final pumpDetailsRepository = ref.watch(pumpDetailsRepositoryProvider);
  return pumpDetailsRepository.watchPumpDetails(pumpId);  
}