import 'package:irrigazione_iot/src/features/sectors/data/fake_sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sector_status_repository.g.dart';

abstract class SectorStatusRepository {
  ///  Returns the most recent status for the sector
  Future<bool?> getSectorStatus(Sector sector);

  /// Emits a stream of the most recent status for the sector
  Stream<bool?> watchSectorStatus(Sector sector);

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
Stream<bool?> sectorStatusStream(
    SectorStatusStreamRef ref, Sector sector) {
  final sectorStatusRepository = ref.watch(sectorStatusRepositoryProvider);
  return sectorStatusRepository.watchSectorStatus(sector);
}

@riverpod
Future<bool?> sectorStatusFuture(
    SectorStatusFutureRef ref, Sector sector) {
  final sectorStatusRepository = ref.watch(sectorStatusRepositoryProvider);
  return sectorStatusRepository.getSectorStatus(sector);
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
