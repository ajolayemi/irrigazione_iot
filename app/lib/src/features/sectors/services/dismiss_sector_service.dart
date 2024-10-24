// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dismiss_sector_service.g.dart';

class DismissSectorService {
  DismissSectorService(
    this._ref,
  );
  final Ref _ref;

  /// Handles the deletion of all data related to a sector
  /// i.e the standard sector data and its connected pumps
  Future<void> dismissSector(String sectorId) async {
    final sectorRepository = _ref.read(sectorRepositoryProvider);
    final sectorPumpsRepository = _ref.read(sectorPumpRepositoryProvider);
    final sectorWasDeleted = await sectorRepository.deleteSector(sectorId);

    // if the sector deletion was completed successfully
    if (sectorWasDeleted) {
      debugPrint('Sector deleted successfully');
      final connectedSectorPump =
          await sectorPumpsRepository.getSectorPump(sectorId);

      if (connectedSectorPump != null) {
        await sectorPumpsRepository.deleteSectorPump(connectedSectorPump.id);
        return;
      }
    }
  }
}

@Riverpod(keepAlive: true)
DismissSectorService dismissSectorService(DismissSectorServiceRef ref) {
  return DismissSectorService(ref);
}
