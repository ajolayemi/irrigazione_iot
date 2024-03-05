import 'package:irrigazione_iot/src/features/sectors/data/fake_sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector_status.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sector_status_repository.g.dart';

abstract class SectorStatusRepository {
  ///  Returns the most recent status for the sector
  Future<SectorStatus?> getSectorStatus(SectorID sectorID);

  /// Emits a stream of the most recent status for the sector
  Stream<SectorStatus?> watchSectorStatus(SectorID sectorID);

  /// Toggles the status of the sector
  Future<void> toggleSectorStatus(Sector sector, String status);

  /// Emits the most recent irrigation date for the sector
  Stream<DateTime?> watchSectorLastIrrigation(Sector sector);

  /// Returns the most recent irrigation date for the sector
  Future<DateTime?> getSectorLastIrrigation(Sector sector);
}

@Riverpod(keepAlive: true)
SectorStatusRepository sectorStatusRepository(SectorStatusRepositoryRef ref) {
  return FakeSectorStatusRepository();
  // todo replace with real implementation
}

@riverpod
Stream<SectorStatus?> sectorStatusStream(
    SectorStatusStreamRef ref, SectorID sectorID) {
  final sectorStatusRepository = ref.watch(sectorStatusRepositoryProvider);
  return sectorStatusRepository.watchSectorStatus(sectorID);
}

@riverpod
Future<SectorStatus?> sectorStatusFuture(
    SectorStatusFutureRef ref, SectorID sectorID) {
  final sectorStatusRepository = ref.watch(sectorStatusRepositoryProvider);
  return sectorStatusRepository.getSectorStatus(sectorID);
}

@riverpod
Stream<DateTime?> sectorLastIrrigatedStream(
    SectorLastIrrigatedStreamRef ref, Sector sector) {
  final sectorStatusRepository = ref.watch(sectorStatusRepositoryProvider);
  return sectorStatusRepository.watchSectorLastIrrigation(sector);
}

@riverpod
Future<DateTime?> sectorLastIrrigatedFuture(
    SectorLastIrrigatedFutureRef ref, Sector sector) {
  final sectorStatusRepository = ref.watch(sectorStatusRepositoryProvider);
  return sectorStatusRepository.getSectorLastIrrigation(sector);
}
