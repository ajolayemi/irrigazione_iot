import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/supabase_pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'pump_repository.g.dart';

abstract class PumpRepository {
  // watch the pumps pertaining to a company
  Stream<List<Pump?>> watchCompanyPumps(String companyId);
  // watches a specified pump with the given pumpId
  Stream<Pump?> watchPump(String pumpId);
  // creates a pump
  Future<Pump?> createPump(Pump pump, String companyId);
  // updates a pump
  Future<Pump?> updatePump(Pump pump, String companyId);
  // deletes a pump
  Future<bool> deletePump(String pumpId);
  // watches a list of already used pump names for a specified company
  // this is used in form validation to prevent duplicate pump names for a company
  Stream<List<String?>> watchCompanyUsedPumpNames(String companyId);
  // watches a list of already used pump on commands for a specified company
  // this is used in form validation to prevent duplicate pump on commands for a company
  Stream<List<String?>> watchCompanyUsedPumpOnCommands(String companyId);
  // watches a list of already used pump off commands for a specified company
  // this is used in form validation to prevent duplicate pump off commands for a company
  Stream<List<String?>> watchCompanyUsedPumpOffCommands(String companyId);
}

@Riverpod(keepAlive: true)
PumpRepository pumpRepository(PumpRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabasePumpRepository(supabaseClient);
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
Stream<Pump?> pumpStream(
  PumpStreamRef ref,
  String pumpId,
) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  return pumpRepository.watchPump(pumpId);
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
