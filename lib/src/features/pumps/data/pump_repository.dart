import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pump_repository.g.dart';

abstract class PumpRepository {
  Stream<List<Pump>> watchCompanyPumps(String companyId);
  Future<List<Pump>> getCompanyPumps(String companyId);

}

@Riverpod(keepAlive: true)
PumpRepository pumpRepository(PumpRepositoryRef ref) {
  return FakePumpRepository();
  // todo replace with real implementation
}

@riverpod
Stream<List<Pump>> companyPumpsStream(CompanyPumpsStreamRef ref, String companyId) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  return pumpRepository.watchCompanyPumps(companyId);
}

@riverpod
Future<List<Pump>> companyPumpsFuture(CompanyPumpsFutureRef ref, String companyId) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  return pumpRepository.getCompanyPumps(companyId);
}
