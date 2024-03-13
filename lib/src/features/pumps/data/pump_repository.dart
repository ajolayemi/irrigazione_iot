import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pump_repository.g.dart';

abstract class PumpRepository {
  // watch the pumps pertaining to a company
  Stream<List<Pump?>> watchCompanyPumps(CompanyID companyId);
  // get the pumps pertaining to a company
  Future<List<Pump?>> getCompanyPumps(CompanyID companyId);
  // watches a specified pump with the given pumpId
  Stream<Pump?> watchPump(PumpID pumpId);
  // gets a specified pump with the given pumpId
  Future<Pump?> getPump(PumpID pumpId);
  // creates a pump
  Future<Pump?> createPump(Pump pump, CompanyID companyId);
  // updates a pump
  Future<Pump?> updatePump(Pump pump, CompanyID companyId);
  // deletes a pump
  Future<bool> deletePump(PumpID pumpId);
  // watches a list of already used pump names for a specified company
  // this is used in form validation to prevent duplicate pump names for a company
  Stream<List<String?>> watchCompanyUsedPumpNames(CompanyID companyId);
  // watches a list of already used pump on commands for a specified company
  // this is used in form validation to prevent duplicate pump on commands for a company
  Stream<List<String?>> watchCompanyUsedPumpOnCommands(CompanyID companyId);
  // watches a list of already used pump off commands for a specified company
  // this is used in form validation to prevent duplicate pump off commands for a company
  Stream<List<String?>> watchCompanyUsedPumpOffCommands(CompanyID companyId);
}

@Riverpod(keepAlive: true)
PumpRepository pumpRepository(PumpRepositoryRef ref) {
  return FakePumpRepository();
  // todo replace with real implementation
}

@riverpod
Stream<List<Pump?>> companyPumpsStream(
  CompanyPumpsStreamRef ref,
) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return const Stream.empty();
  return pumpRepository.watchCompanyPumps(currentSelectedCompanyByUser.id);
}

@riverpod
Future<List<Pump?>> companyPumpsFuture(CompanyPumpsFutureRef ref) {
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

@riverpod
Stream<List<String?>> companyUsedPumpNamesStream(
  CompanyUsedPumpNamesStreamRef ref,
) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return const Stream.empty();

  return pumpRepository
      .watchCompanyUsedPumpNames(currentSelectedCompanyByUser.id);
}

@riverpod
Stream<List<String?>> companyUsedPumpOnCommandsStream(
  CompanyUsedPumpOnCommandsStreamRef ref,
) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return const Stream.empty();

  return pumpRepository
      .watchCompanyUsedPumpOnCommands(currentSelectedCompanyByUser.id);
}

@riverpod
Stream<List<String?>> companyUsedPumpOffCommandsStream(
  CompanyUsedPumpOffCommandsStreamRef ref,
) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return const Stream.empty();

  return pumpRepository
      .watchCompanyUsedPumpOffCommands(currentSelectedCompanyByUser.id);
}
