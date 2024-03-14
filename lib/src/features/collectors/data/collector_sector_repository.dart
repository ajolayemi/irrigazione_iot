import 'package:irrigazione_iot/src/features/collectors/data/fake_collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_sector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'collector_sector_repository.g.dart';

abstract class CollectorSectorRepository {
  /// Add a new [CollectorSector] to database and return the added [CollectorSector] if the addition was successful
  Future<CollectorSector?> addCollectorSector(CollectorSector collectorSector);

  /// Delete a [CollectorSector] from database and return true if the deletion was successful
  Future<bool> deleteCollectorSector(String collectorId, String sectorId);

  /// Get a list of [CollectorSector] from database if any
  Future<List<CollectorSector?>> getCollectorSectors(String collectorId);

  /// Emits a list of [CollectorSector] from database if any
  Stream<List<CollectorSector?>> watchCollectorSectors(String collectorId);
}


@Riverpod(keepAlive: true)
CollectorSectorRepository collectorSectorRepository(CollectorSectorRepositoryRef ref) {
  // todo return remote repository as default
  return FakeCollectorSectorRepository();
}

@riverpod
Stream<List<CollectorSector?>> collectorSectorsStream(
    CollectorSectorsStreamRef ref, String collectorId) {
  final collectorSectorRepo = ref.watch(collectorSectorRepositoryProvider);
  return collectorSectorRepo.watchCollectorSectors(collectorId);
}

@riverpod
Future<List<CollectorSector?>> collectorSectorsFuture(
    CollectorSectorsFutureRef ref, String collectorId) {
  final collectorSectorRepo = ref.watch(collectorSectorRepositoryProvider);
  return collectorSectorRepo.getCollectorSectors(collectorId);
}