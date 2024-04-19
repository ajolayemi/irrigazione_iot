import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_return_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/sectors/data/supabase_sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pump.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'sector_pump_repository.g.dart';

abstract class SectorPumpRepository {
  /// Add a new [SectorPump] to database and return the added [SectorPump] if the addition was successful
  Future<SectorPump?> createSectorPump(SectorPump sectorPump);

  /// Delete a [SectorPump] from database and return true if the deletion was successful
  Future<bool> deleteSectorPump(String sectorPumpId);

  /// Get the [SectorPump] connected to the specified [sectorId] from database if any
  Future<SectorPump?> getSectorPump(String sectorId);

  /// Watch the [SectorPump] connected to the specified [sectorId] from database
  Stream<SectorPump?> watchSectorPump(String sectorId);

  /// Gets a list of [Pump]s of the current company that aren't connected yet to a sector
  Future<List<Pump>?> getAvailablePumps(
    String sectorId,
    String companyId,
    String? alreadyConnectedPumpId,
  );
}

@Riverpod(keepAlive: true)
SectorPumpRepository sectorPumpRepository(SectorPumpRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseSectorPumpRepository(supabaseClient);
}

@riverpod
Stream<SectorPump?> sectorPumpStream(SectorPumpStreamRef ref, String sectorId) {
  final sectorPumpRepo = ref.watch(sectorPumpRepositoryProvider);
  return sectorPumpRepo.watchSectorPump(sectorId);
}

@riverpod
Future<SectorPump?> sectorPumpFuture(SectorPumpFutureRef ref, String sectorId) {
  final sectorPumpRepo = ref.watch(sectorPumpRepositoryProvider);
  return sectorPumpRepo.getSectorPump(sectorId);
}

@riverpod
Future<List<Pump>?> availablePumpsFuture(
  AvailablePumpsFutureRef ref, {
  required String sectorId,
  String? alreadyConnectedPumpId,
}) {
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;

  if (currentSelectedCompanyByUser == null) {
    return Future.value(null);
  }
  final sectorPumpRepo = ref.watch(sectorPumpRepositoryProvider);
  return sectorPumpRepo.getAvailablePumps(
    sectorId,
    currentSelectedCompanyByUser.id,
    alreadyConnectedPumpId,
  );
}

// Keeps track of the id of the pump selected to be connected to the sector
final selectPumpRadioButtonProvider =
    StateProvider<RadioButtonReturnType?>((ref) {
  return null;
});
