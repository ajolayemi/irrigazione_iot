import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/supabase_pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'pump_repository.g.dart';

abstract class PumpRepository {
  /// Gets the list of [Pump]s  pertaining to a company
  Future<List<Pump>?> getCompanyPumps(String companyId);

  /// Gets a list of all the pumps in the database
  Future<List<Pump>?> getAllPumps();

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
PumpRepository pumpRepository(Ref ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabasePumpRepository(supabaseClient);
}

/// Fetches the list of pumps pertaining to the company selected by the user
@riverpod
Future<List<Pump>?> companyPumps(Ref ref) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  final currentSelectedCompanyByUser = ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return Future.value([]);
  return pumpRepository.getCompanyPumps(currentSelectedCompanyByUser.id);
}

/// Fetches all pumps available in the database
@riverpod
Future<List<Pump>?> pumps(Ref ref) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  return pumpRepository.getAllPumps();
}

/// Fetches the pump with the given pumpId
@riverpod
Future<Pump?> pumpFuture(Ref ref, String pumpId) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  return pumpRepository.getPump(pumpId);
}

/// Fetches the list of already used pump names for the company selected by the user
@riverpod
Future<List<String?>> companyUsedPumpNamesFuture(Ref ref) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  final currentSelectedCompanyByUser = ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return Future.value([]);

  return pumpRepository.getCompanyUsedPumpNames(currentSelectedCompanyByUser.id);
}

/// Fetches the list of already used pump commands for the company selected by the user
@riverpod
Future<List<String?>> companyUsedPumpCommandsFuture(Ref ref) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  final currentSelectedCompanyByUser = ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return Future.value([]);

  return pumpRepository.getCompanyUsedPumpCommands(currentSelectedCompanyByUser.id);
}

/// Fetches the list of already used mqtt message names
@riverpod
Future<List<String?>> pumpUsedMqttMessageNamesFuture(Ref ref) {
  final pumpRepository = ref.watch(pumpRepositoryProvider);
  return pumpRepository.getUsedMqttMessageNames();
}
