import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/supabase_pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'pump_repository.g.dart';

abstract class PumpRepository {
  /// watch the pumps pertaining to a company
  Stream<List<Pump?>> watchCompanyPumps(String companyId);

  /// Gets the list of [Pump]s  pertaining to a company
  Future<List<Pump>?> getCompanyPumps(String companyId);

  /// Gets a list of all the pumps in the database
  Future<List<Pump>?> getAllPumps();

  /// watches a specified pump with the given pumpId
  Stream<Pump?> watchPump(String pumpId);

  /// Fetches the [Pump] with the given [pumpId]
  Future<Pump?> getPump(String pumpId);

  /// creates a pump
  Future<Pump?> createPump(Pump pump);

  /// updates a pump
  Future<Pump?> updatePump(Pump pump);

  /// deletes a pump
  Future<bool> deletePump(String pumpId);

  /// fetches a list of already used pump names for a specified company
  /// this is used in form validation to prevent duplicate pump names for a company
  Future<List<String?>> getCompanyUsedPumpNames(String companyId);

  /// fetches a list of already used commands (both on and offs) for the pumps in a specified
  /// company. This is used in form validation to prevent duplicate pump commands for a company
  Future<List<String?>> getCompanyUsedPumpCommands(String companyId);

  /// emits the list of mqtt messages names already used generally
  Future<List<String?>> getUsedMqttMessageNames();
}

@Riverpod(keepAlive: true)
PumpRepository pumpRepository(PumpRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabasePumpRepository(supabaseClient);
}


/// Emits the list of pumps pertaining to the company selected by the user
@riverpod
Stream<List<Pump?>> companyPumpsStream(
  CompanyPumpsStreamRef ref,
) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return Stream.value([]);
  return pumpRepository.watchCompanyPumps(currentSelectedCompanyByUser.id);
}

/// Fetches the list of pumps pertaining to the company selected by the user
@riverpod
Future<List<Pump>?> companyPumpsFuture(
  CompanyPumpsFutureRef ref,
) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return Future.value([]);
  return pumpRepository.getCompanyPumps(currentSelectedCompanyByUser.id);
}


/// Fetches all pumps available in the database
@riverpod
Future<List<Pump>?> allPumpsFuture(AllPumpsFutureRef ref) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  return pumpRepository.getAllPumps();
}


/// Emits the pump with the given pumpId
@riverpod
Stream<Pump?> pumpStream(PumpStreamRef ref, String pumpId) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  return pumpRepository.watchPump(pumpId);
}


/// Fetches the pump with the given pumpId
@riverpod
Future<Pump?> pumpFuture(PumpFutureRef ref, String pumpId) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  return pumpRepository.getPump(pumpId);
}

/// Fetches the list of already used pump names for the company selected by the user
@riverpod
Future<List<String?>> companyUsedPumpNamesFuture(
  CompanyUsedPumpNamesFutureRef ref,
) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return Future.value([]);

  return pumpRepository
      .getCompanyUsedPumpNames(currentSelectedCompanyByUser.id);
}

/// Fetches the list of already used pump commands for the company selected by the user
@riverpod
Future<List<String?>> companyUsedPumpCommandsFuture(
  CompanyUsedPumpCommandsFutureRef ref,
) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return Future.value([]);

  return pumpRepository
      .getCompanyUsedPumpCommands(currentSelectedCompanyByUser.id);
}

/// Fetches the list of already used mqtt message names
@riverpod
Future<List<String?>> pumpUsedMqttMessageNamesFuture(
  PumpUsedMqttMessageNamesFutureRef ref,
) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  return pumpRepository.getUsedMqttMessageNames();
}
