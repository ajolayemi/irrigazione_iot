import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/features/sectors/data/supabase_sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_pump.dart';
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
  Future<List<Pump>?> getAvailablePumps({
    required String companyId,
    String? alreadyConnectedPumpId,
  });
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
  String? alreadyConnectedPumpId,
}) {
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;

  if (currentSelectedCompanyByUser == null) {
    return Future.value(null);
  }
  final sectorPumpRepo = ref.watch(sectorPumpRepositoryProvider);
  return sectorPumpRepo.getAvailablePumps(
    companyId: currentSelectedCompanyByUser.id,
    alreadyConnectedPumpId: alreadyConnectedPumpId,
  );
}

