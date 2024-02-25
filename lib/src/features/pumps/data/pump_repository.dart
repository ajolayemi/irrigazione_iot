import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/selected_company_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pump_repository.g.dart';

abstract class PumpRepository {
  Stream<List<Pump>> watchCompanyPumps(String companyId);
  Future<List<Pump>> getCompanyPumps(String companyId);
  Stream<Pump?> watchPump(String pumpId);
  Future<Pump?> getPump(String pumpId);
}

@Riverpod(keepAlive: true)
PumpRepository pumpRepository(PumpRepositoryRef ref) {
  return FakePumpRepository();
  // todo replace with real implementation
}

@riverpod
Stream<List<Pump>> companyPumpsStream(
  CompanyPumpsStreamRef ref,
) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return const Stream.empty();

  return pumpRepository.watchCompanyPumps(currentSelectedCompanyByUser.id);
}

@riverpod
Future<List<Pump>> companyPumpsFuture(
    CompanyPumpsFutureRef ref) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return Future.value([]);
  return pumpRepository.getCompanyPumps(currentSelectedCompanyByUser.id);
}

@riverpod
Stream<Pump?> pumpStream(
  PumpStreamRef ref,
  String pumpId,
) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  return pumpRepository.watchPump(pumpId);
}

@riverpod
Future<Pump?> pumpFuture(
  PumpFutureRef ref,
  String pumpId,
) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  return pumpRepository.getPump(pumpId);
}
