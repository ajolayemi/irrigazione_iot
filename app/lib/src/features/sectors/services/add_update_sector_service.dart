import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_pump.dart';

part 'add_update_sector_service.g.dart';

class AddUpdateSectorService {
  const AddUpdateSectorService(
    this.ref,
  );
  final Ref ref;

  Future<void> createSector({
    required Sector sector,
    required String pumpIdToConnectToSector,
  }) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    final sectorRepo = ref.read(sectorRepositoryProvider);
    final sectorPumpsRepo = ref.read(sectorPumpRepositoryProvider);
    final selectedCompanyRepo = ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    //create sector
    final createdSector = await sectorRepo.createSector(
      sector.copyWith(companyId: companyId),
    );

    _invalidateSectorList();

    if (createdSector == null || pumpIdToConnectToSector.isEmpty) {
      debugPrint('Sector creation failed');
      return;
    }

    final sectorPump = SectorPump(
      id: '',
      sectorId: createdSector.id,
      pumpId: pumpIdToConnectToSector,
    );
    debugPrint(
        'Creating sector pump: ${sectorPump.toJson()} for sector: ${createdSector.name}');
    final createdSectorPump = await sectorPumpsRepo.createSectorPump(
      sectorPump,
    );
    debugPrint('Created sectorPump: ${createdSectorPump?.toJson()}}');
  }

  Future<void> updateSector({
    required Sector sector,
    required String updatedConnectedPumpId,
  }) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    final sectorRepo = ref.read(sectorRepositoryProvider);
    final sectorPumpsRepository = ref.read(sectorPumpRepositoryProvider);
    final selectedCompanyRepo = ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    // update sector, the function will return early if the sector is the same as the old one
    final updatedSector =
        await sectorRepo.updateSector(sector.copyWith(companyId: companyId));

    _invalidateSectorList();
    if (updatedSector == null) return;

    // Get the current pump connected to the sector
    final currentSectorPump =
        await sectorPumpsRepository.getSectorPump(updatedSector.id);

    // if there were no previously connected pumps to the sector and the user didn't connect any new pump to the sector
    if (currentSectorPump == null && updatedConnectedPumpId.isEmpty) {
      debugPrint(
          'No new pumps to connect to the sector: ${updatedSector.name}');
      return;
    }

    // If a pump was previously connected to the sector
    if (currentSectorPump != null) {
      // if the updated connected pump id is different from the previously connected one,
      // meaning that user chose not to connect any pump to the sector or a new pump was selected, remove the old pump
      if (updatedConnectedPumpId != currentSectorPump.pumpId) {
        debugPrint(
            'Removing pump: ${currentSectorPump.pumpId} from sector: ${updatedSector.name}');
        await sectorPumpsRepository.deleteSectorPump(currentSectorPump.id);
      } else if (updatedConnectedPumpId == currentSectorPump.pumpId) {
        // if the updated connected pump id is the same as the previously connected one, return early
        debugPrint(
            'No new pumps to connect to the sector: ${updatedSector.name}');
        return;
      }
    }

    // Reaching here means their is the need to connect a new pump to the sector
    final newSectorPump = SectorPump(
      id: '',
      sectorId: updatedSector.id,
      pumpId: updatedConnectedPumpId,
    );

    final a = await sectorPumpsRepository.createSectorPump(newSectorPump);
    debugPrint(
        'Updating sector pump: ${a?.toJson()} for sector: ${updatedSector.name}');

    return;
  }

  /// Invalidate the list of sectors to force a refresh
  void _invalidateSectorList() {
    ref.invalidate(companySectorsFutureProvider);
  }
}

@Riverpod(keepAlive: true)
AddUpdateSectorService addUpdateSectorService(AddUpdateSectorServiceRef ref) {
  return AddUpdateSectorService(ref);
}
