import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_sector.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/selected_company_repository.dart';

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
    print('Update collector coming soon...');
    // todo implement updateCollector
  }
}

@riverpod
AddUpdateCollectorService addUpdateCollectorService(
    AddUpdateCollectorServiceRef ref) {
  return AddUpdateCollectorService(ref);
}
