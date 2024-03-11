import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/sectors/data/fake_sector_pumps_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pump.dart';

part 'sector_pump_repository.g.dart';

abstract class SectorPumpRepository {
  /// Add a new [SectorPump] to database and return the added [SectorPump] if the addition was successful
  Future<SectorPump?> addSectorPump(SectorPump sectorPump);

  /// Delete a [SectorPump] from database and return true if the deletion was successful
  Future<bool> deleteSectorPump(String sectorId, String pumpId);

  /// Get a list of [SectorPump] from database if any
  Future<List<SectorPump?>> getSectorPumps(String sectorId);

  /// Emits a list of [SectorPump] from database if any
  Stream<List<SectorPump?>> watchSectorPumps(String sectorId);
}

@Riverpod(keepAlive: true)
SectorPumpRepository sectorPumpRepository(SectorPumpRepositoryRef ref) {
  // todo return remote repository as default
  return FakeSectorPumpRepository();
}

@riverpod
Stream<List<SectorPump?>> sectorPumpsStream(
    SectorPumpsStreamRef ref, String sectorId) {
  final sectorPumpRepo = ref.watch(sectorPumpRepositoryProvider);
  return sectorPumpRepo.watchSectorPumps(sectorId);
}

@riverpod
Future<List<SectorPump?>> sectorPumpsFuture(
    SectorPumpsFutureRef ref, String sectorId) {
  final sectorPumpRepo = ref.watch(sectorPumpRepositoryProvider);
  return sectorPumpRepo.getSectorPumps(sectorId);
}

// Keeps track of the ids of the pumps selected to be connected to the sector

final selectedPumpsIdProvider = StateProvider<List<String?>>((ref) {
  return [];
});
