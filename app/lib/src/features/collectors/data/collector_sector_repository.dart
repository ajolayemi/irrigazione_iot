import 'package:irrigazione_iot/src/features/collectors/models/collector.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/collectors/data/supabase_collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector_sector.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'collector_sector_repository.g.dart';

abstract class CollectorSectorRepository {
  /// Add a new [CollectorSector] to database and return the added [CollectorSector] if the addition was successful
  Future<CollectorSector?> createCollectorSector(
      CollectorSector collectorSector);

  /// Delete a [CollectorSector] from database and return true if the deletion was successful
  Future<bool> deleteCollectorSector(
    String collectorSectorId,
  );

  /// Get a list of [CollectorSector] from database if any
  Future<List<CollectorSector?>> getCollectorSectorsById(String collectorId);

  /// Emits a list of [CollectorSector] pertaining to a collector from database if any
  Stream<List<CollectorSector?>> watchCollectorSectorsById(String collectorId);

  /// Get the [Collector] that is connected to the [Sector] with the provided [sectorId]
  Future<Collector?> getCollectorBySectorId(String sectorId);

  /// Emits the collectorId of the [Collector] that is connected to the [Sector] with the provided [sectorId]
  Stream<String?> watchCollectorIdBySectorId(String sectorId);
}

@Riverpod(keepAlive: true)
CollectorSectorRepository collectorSectorRepository(
    CollectorSectorRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseCollectorSectorRepository(supabaseClient);
}

@riverpod
Stream<List<CollectorSector?>> collectorSectorsStream(
    CollectorSectorsStreamRef ref, String collectorId) {
  final collectorSectorRepo = ref.watch(collectorSectorRepositoryProvider);
  return collectorSectorRepo.watchCollectorSectorsById(collectorId);
}

@riverpod
Future<List<CollectorSector?>> collectorSectorsFuture(
    CollectorSectorsFutureRef ref, String collectorId) {
  final collectorSectorRepo = ref.watch(collectorSectorRepositoryProvider);
  return collectorSectorRepo.getCollectorSectorsById(collectorId);
}


/// Provider that emits the number of sectors that are currently switched on for a particular
/// collector indicated by the provided [String]
@riverpod
Stream<int> numberOfSectorsSwitchedOn(NumberOfSectorsSwitchedOnRef ref,
    {required String collectorId}) {
  // Get a list of collector sectors pertaining to the provided collector
  final collectorSectors =
      ref.watch(collectorSectorsFutureProvider(collectorId)).valueOrNull;
  if (collectorSectors == null) return Stream.value(0);

  int sectorsSwitchedOn = 0;

  // Loop through the list of collector sectors and check if at least a sector is switched on
  for (final collectorSector in collectorSectors) {
    final sector =
        ref.watch(sectorStreamProvider(collectorSector!.sectorId)).valueOrNull;
    if (sector == null) return Stream.value(0);
    final status = ref.watch(sectorStatusStreamProvider(sector.id));
    if (status.valueOrNull?.statusBoolean == true) {
      sectorsSwitchedOn++;
    } else {
      continue;
    }
  }

  return Stream.value(sectorsSwitchedOn);
}

@riverpod
Future<Collector?> collectorBySectorId(
    CollectorBySectorIdRef ref, String sectorId) {
  final collectorSectorRepo = ref.watch(collectorSectorRepositoryProvider);
  return collectorSectorRepo.getCollectorBySectorId(sectorId);
}

@riverpod
Stream<String?> collectorIdBySectorIdStream(
    CollectorIdBySectorIdStreamRef ref, String sectorId) {
  final collectorSectorRepo = ref.watch(collectorSectorRepositoryProvider);
  return collectorSectorRepo.watchCollectorIdBySectorId(sectorId);
}