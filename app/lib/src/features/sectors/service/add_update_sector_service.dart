import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pump.dart';

part 'add_update_sector_service.g.dart';

class AddUpdateSectorService {
  const AddUpdateSectorService(
    this.ref,
  );
  final Ref ref;

  Future<void> createSector(Sector sector) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    final sectorRepo = ref.read(sectorRepositoryProvider);
    final sectorPumpsRepo = ref.read(sectorPumpRepositoryProvider);
    final selectedCompanyRepo = ref.read(selectedCompanyRepositoryProvider);
    final pumpsToConnectToSector = ref.read(selectedPumpsIdProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    //create sector
    final createdSector =
        await sectorRepo.createSector(sector.copyWith(companyId: companyId));

    if (createdSector != null && pumpsToConnectToSector.isNotEmpty) {
      // loop over each pump and connect it to the created sector
      for (final pumpId in pumpsToConnectToSector) {
        final sectorPump = SectorPump(
          id: '',
          sectorId: createdSector.id,
          pumpId: pumpId!,
        );
        debugPrint(
            'Creating sector pump: ${sectorPump.toJson()} for sector: ${createdSector.name}');
        final createdSectorPump =
            await sectorPumpsRepo.createSectorPump(sectorPump);
        debugPrint('Created sectorPump: ${createdSectorPump?.toJson()}}');
      }
    }
  }

  Future<void> updateSector(Sector sector) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    final sectorRepo = ref.read(sectorRepositoryProvider);
    final sectorPumpsRepository = ref.read(sectorPumpRepositoryProvider);
    final selectedCompanyRepo = ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);
    final updatedConnectedPumpIds = ref.read(selectedPumpsIdProvider);

    // update sector, the function will return early if the sector is the same as the old one
    final updatedSector =
        await sectorRepo.updateSector(sector.copyWith(companyId: companyId));

    if (updatedSector != null) {
      // Get the list of current pumps connected to the sector
      final currentSectorPumps =
          await sectorPumpsRepository.getSectorPumps(updatedSector.id);

      // Since we're updating sector data, it's possible that the user has removed some pumps
      // from the sector. We need to remove those pumps from the sectorPumps collection
      // Get a list of pumpIds that are no longer connected to the sector
      final sectorPumpIdsToRemove = currentSectorPumps
          .where((sp) => !updatedConnectedPumpIds.contains(sp?.pumpId))
          .map((sp) => sp?.id)
          .toList();

      // Remove the pumps that are no longer connected to the sector
      if (sectorPumpIdsToRemove.isNotEmpty) {
        for (final sectorPumpId in sectorPumpIdsToRemove) {
          debugPrint(
              'Removing pump: $sectorPumpId from sector: ${updatedSector.name}');
          await sectorPumpsRepository.deleteSectorPump(sectorPumpId!);
        }
      }

      // If the user didn't connect any new pumps to the sector, we can return early
      if (updatedConnectedPumpIds.isEmpty) {
        debugPrint(
            'No new pumps to connect to the sector: ${updatedSector.name}');
        return;
      }

      final newPumps = updatedConnectedPumpIds
          .where(
              (pumpId) => !currentSectorPumps.any((sp) => sp?.pumpId == pumpId))
          .toList();

      if (newPumps.isEmpty) {
        return;
      }

      debugPrint('New pumps to connect to the sector: $newPumps');

      // Update the sectorPumps  with the new list of pumps connected to the sector
      for (final pumpId in newPumps) {
        final sectorPump = SectorPump(
          id: '',
          sectorId: updatedSector.id,
          pumpId: pumpId!,
        );

        // Reaching here means we have new pump(s) to connect to the sector, that is
        // why the addSectorPump method is called instead of updateSectorPump
        final a = await sectorPumpsRepository.createSectorPump(sectorPump);
        debugPrint(
            'Updating sector pump: ${a?.toJson()} for sector: ${updatedSector.name}');
      }
      return;
    }
    return;
  }
}

@Riverpod(keepAlive: true)
AddUpdateSectorService addUpdateSectorService(AddUpdateSectorServiceRef ref) {
  return AddUpdateSectorService(ref);
}
