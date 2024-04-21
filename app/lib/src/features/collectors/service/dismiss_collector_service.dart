import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/collector_repository.dart';
import '../data/collector_sector_repository.dart';
import '../model/collector.dart';

part 'dismiss_collector_service.g.dart';

class DismissCollectorService {
  const DismissCollectorService(
    this._ref,
  );
  final Ref _ref;

  /// Handles the deletion of all data related to a collector
  /// i.e the standard collector data and its connected sectors
  Future<void> dismissCollector(CollectorID collectorId) async {
    final collectorRepo = _ref.read(collectorRepositoryProvider);
    final collectorSectorRepo = _ref.read(collectorSectorRepositoryProvider);
    final collectorWasDeleted =
        await collectorRepo.deleteCollector(collectorId);
    // if the collector deletion was completed successfully
    if (collectorWasDeleted) {
      debugPrint('Collector deleted successfully');
      // get a list of all the sectors connected to the collector
      final collectorSectors =
          await collectorSectorRepo.getCollectorSectorsById(
        collectorId: collectorId,
      );

      if (collectorSectors.isEmpty) {
        debugPrint('No sectors connected to the collector');
        return;
      }

      // delete all the sectors connected to the collector
      for (final collectorSector in collectorSectors) {
        debugPrint('Deleting collector sector: ${collectorSector?.sectorId}');
        await collectorSectorRepo.deleteCollectorSector(
          collectorSector: collectorSector!,
        );
      }
    }
  }
}

@riverpod
DismissCollectorService dismissCollectorService(Ref ref) {
  return DismissCollectorService(ref);
}
