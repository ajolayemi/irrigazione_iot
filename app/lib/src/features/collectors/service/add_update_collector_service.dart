import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../authentication/data/auth_repository.dart';
import '../data/collector_repository.dart';
import '../data/collector_sector_repository.dart';
import '../model/collector.dart';
import '../model/collector_sector.dart';
import '../../company_users/data/selected_company_repository.dart';

part 'add_update_collector_service.g.dart';

class AddUpdateCollectorService {
  const AddUpdateCollectorService(
    this._ref,
  );
  final Ref _ref;

  Future<void> createCollector(Collector collector) async {
    final user = _ref.read(authRepositoryProvider).currentUser;
    if (user == null) {
      debugPrint('Exiting createCollector, user is null');
      return;
    }

    final selectedCompanyRepo = _ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    if (companyId == null) {
      debugPrint('Exiting createCollector, companyId is null');
      return;
    }

    final collectorRepo = _ref.read(collectorRepositoryProvider);
    final collectorSectorsRepo = _ref.read(collectorSectorRepositoryProvider);
    final sectorsToConnectToCollector = _ref.read(selectedSectorsIdProvider);

    // create collector
    final createdCollector = await collectorRepo.addCollector(
      collector,
      companyId,
    );

    if (createdCollector == null) {
      debugPrint('Exiting createCollector, createdCollector is null');
      return;
    }

    if (sectorsToConnectToCollector.isNotEmpty) {
      // loop over each sector and connect it to the created collector
      for (final sectorId in sectorsToConnectToCollector) {
        final collectorSector = CollectorSector(
            collectorId: createdCollector.id,
            sectorId: sectorId!,
            companyId: companyId);
        debugPrint(
            'Creating collector sector: ${collectorSector.toJson()} for collector: ${createdCollector.name}');
        final createdCollectorSector =
            await collectorSectorsRepo.addCollectorSector(
          collectorSector: collectorSector,
        );
        debugPrint(
            'Created collectorSector: ${createdCollectorSector?.toJson()}');
      }
    }
  }

  Future<void> updateCollector(Collector collector) async {
    final user = _ref.read(authRepositoryProvider).currentUser;
    if (user == null) {
      debugPrint('Exiting updateCollector, user is null');
      return;
    }

    final selectedCompanyRepo = _ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    if (companyId == null) {
      debugPrint('Exiting updateCollector, companyId is null');
      return;
    }

    final collectorRepo = _ref.read(collectorRepositoryProvider);
    final collectorSectorsRepo = _ref.read(collectorSectorRepositoryProvider);
    final updatedConnectedSectorIds = _ref.read(selectedSectorsIdProvider);

    // update collector, the update collector func returns earlier
    // if the collector data has never changed or if the collector that user
    // is trying to update does not exist before this call
    final updatedCollector = await collectorRepo.updateCollector(
      collector,
      companyId,
    );

    if (updatedCollector == null) {
      debugPrint('Exiting updateCollector, updatedCollector is null');
      return;
    }

    // Get the list of current sectors connected to this collector
    final currentCollectorSectors =
        await collectorSectorsRepo.getCollectorSectorsById(
      collectorId: updatedCollector.id,
    );

    // Get the list of sectors that are not connected to the collector anymore
    // since this is an update event, it's possible that user chose not to connect
    // some sectors that were previously connected to the collector
    final sectorsToDisconnect = currentCollectorSectors
        .where((collectorSector) =>
            !updatedConnectedSectorIds.contains(collectorSector?.sectorId))
        .toList();

    // Disconnect the sectors that are no longer connected to the collector
    if (sectorsToDisconnect.isNotEmpty) {
      for (final collectorSector in sectorsToDisconnect) {
        debugPrint(
            'Deleting collector sector: ${collectorSector?.toJson()} for collector: ${updatedCollector.name}');

        await collectorSectorsRepo.deleteCollectorSector(
          collectorSector: collectorSector!,
        );
      }
    }

    // If the user didn't connect any new sectors to the collector, we can return early
    if (updatedConnectedSectorIds.isEmpty) {
      debugPrint(
          'No new sectors to connect to the collector: ${updatedCollector.name}');
      return;
    }

    // Get the list of sectors that are not connected to the collector
    final sectorsToConnect = updatedConnectedSectorIds
        .where((sectorId) =>
            !currentCollectorSectors.any((cs) => cs?.sectorId == sectorId))
        .toList();


    if (sectorsToConnect.isEmpty) return;

    for (final sectorId in sectorsToConnect) {
      final collectorSector = CollectorSector(
        collectorId: updatedCollector.id,
        sectorId: sectorId!,
        companyId: companyId,
      );

      // Reaching here means new sector(s) where selected to connect to the collector
      debugPrint(
          'Creating collector sector: ${collectorSector.toJson()} for collector: ${updatedCollector.name}');
      await collectorSectorsRepo.addCollectorSector(
        collectorSector: collectorSector,
      );
    }
  }
}

@riverpod
AddUpdateCollectorService addUpdateCollectorService(
    AddUpdateCollectorServiceRef ref) {
  return AddUpdateCollectorService(ref);
}
