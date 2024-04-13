import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/collectors/data/fake_collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_sector.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'collector_sector_repository.g.dart';

abstract class CollectorSectorRepository {
  /// Add a new [CollectorSector] to database and return the added [CollectorSector] if the addition was successful
  Future<CollectorSector?> addCollectorSector(
      {required CollectorSector collectorSector});

  /// Delete a [CollectorSector] from database and return true if the deletion was successful
  Future<bool> deleteCollectorSector({
    required CollectorSector collectorSector,
  });

  /// Get a list of [CollectorSector] from database if any
  Future<List<CollectorSector?>> getCollectorSectorsById(
      {required String collectorId});

  /// Emits a list of [CollectorSector] pertaining to a collector from database if any
  Stream<List<CollectorSector?>> watchCollectorSectorsById(
      {required String collectorId});

  /// Gets a list of [CollectorSector] belonging to a [companyId] from database if any
  Future<List<CollectorSector?>> getCollectorSectorsByCompanyId(
      {required String companyId});

  /// Emits a list of [CollectorSector] belonging to a [companyId] from database if any
  Stream<List<CollectorSector?>> watchCollectorSectorsByCompanyId(
      {required String companyId});
}

@Riverpod(keepAlive: true)
CollectorSectorRepository collectorSectorRepository(
    CollectorSectorRepositoryRef ref) {
  // todo return remote repository as default
  return FakeCollectorSectorRepository();
}

@riverpod
Stream<List<CollectorSector?>> collectorSectorsStream(
    CollectorSectorsStreamRef ref, String collectorId) {
  final collectorSectorRepo = ref.watch(collectorSectorRepositoryProvider);
  return collectorSectorRepo.watchCollectorSectorsById(
      collectorId: collectorId);
}

@riverpod
Future<List<CollectorSector?>> collectorSectorsFuture(
    CollectorSectorsFutureRef ref, String collectorId) {
  final collectorSectorRepo = ref.watch(collectorSectorRepositoryProvider);
  return collectorSectorRepo.getCollectorSectorsById(collectorId: collectorId);
}

@riverpod
Stream<List<CollectorSector?>> collectorSectorsByCompanyStream(
    CollectorSectorsByCompanyStreamRef ref) {
  final collectorSectorRepo = ref.watch(collectorSectorRepositoryProvider);
  final selectedCompanyId =
      ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (selectedCompanyId == null) {
    return Stream.value([]);
  }
  return collectorSectorRepo.watchCollectorSectorsByCompanyId(
    companyId: selectedCompanyId,
  );
}

@riverpod
Future<List<CollectorSector?>> collectorSectorsByCompanyFuture(
    CollectorSectorsByCompanyFutureRef ref) {
  final collectorSectorRepo = ref.watch(collectorSectorRepositoryProvider);
  final selectedCompanyId =
      ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (selectedCompanyId == null) {
    return Future.value([]);
  }
  return collectorSectorRepo.getCollectorSectorsByCompanyId(
    companyId: selectedCompanyId,
  );
}

final sectorIdsOfCollectorBeingEditedProvider =
    StateProvider<List<String?>>((ref) {
  return [];
});

/// A provider to keep track of all sectors that aren't connected to a collector
@riverpod
Stream<List<Sector?>> sectorsNotConnectedToACollectorStream(
  SectorsNotConnectedToACollectorStreamRef ref,
) {
  // get a list of all sectors that a company has
  final sectorsPertainingToCompany =
      ref.watch(sectorListStreamProvider).valueOrNull;

  if (sectorsPertainingToCompany == null) return Stream.value([]);

  // get a list of all sectors that are connected to a collector and
  // belongs to a certain company
  final collectorSectorsPertainingToCompany =
      ref.watch(collectorSectorsByCompanyStreamProvider).valueOrNull;
  if (collectorSectorsPertainingToCompany == null) return Stream.value([]);

  final sectorIdsToOmit = ref.watch(sectorIdsOfCollectorBeingEditedProvider);
  // when user is updating a collector, this check shouldn't be done on the sectors connected to the
  // collector being updated, this is to make sure that the sectors can still be selected or deselected
  final collectorSectorsToProcess = collectorSectorsPertainingToCompany
      .where((collectorSector) =>
          !sectorIdsToOmit.contains(collectorSector?.sectorId))
      .toList();

  // get the ids of the sectors that are connected to a collector
  final connectedSectorIds = collectorSectorsToProcess
      .map((collectorSector) => collectorSector!.sectorId)
      .toList();

  // get the sectors that aren't connected to a collector
  final sectorsNotConnectedToACollector = sectorsPertainingToCompany
      .where((sector) => !connectedSectorIds.contains(sector!.id))
      .toList();
  return Stream.value(sectorsNotConnectedToACollector);
}

// Keeps track of the ids of the [Sector]s selected to be connected to the [Collector]
final selectedSectorsIdProvider = StateProvider<List<String?>>((ref) {
  return [];
});

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
    final status = ref.watch(sectorStatusStreamProvider(sector));
    if (status.valueOrNull == true) {
      sectorsSwitchedOn++;
    } else {
      continue;
    }
  }

  return Stream.value(sectorsSwitchedOn);
}
