// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dismiss_sector_service.g.dart';

class DismissSectorService {
  DismissSectorService(
    this._ref,
  );
  final Ref _ref;

  /// Handles the deletion of all data related to a sector
  /// i.e the standard sector data and its connected pumps
  Future<void> dismissSector(SectorID sectorId) async {
    final sectorRepository = _ref.read(sectorsRepositoryProvider);
    final sectorPumpsRepository = _ref.read(sectorPumpRepositoryProvider);
    final sectorWasDeleted = await sectorRepository.deleteSector(sectorId);
    // if the sector deletion was completed successfully
    if (sectorWasDeleted) {
      debugPrint('Sector deleted successfully');
      // get a list of all the pumps connected to the sector
      final sectorPumps = await sectorPumpsRepository.getSectorPumps(sectorId);
      if (sectorPumps.isEmpty) {
        return;
      }
      // delete all the pumps connected to the sector
      for (final sectorPump in sectorPumps) {
        debugPrint('Deleting sector pump: ${sectorPump?.pumpId}');
        await sectorPumpsRepository.deleteSectorPump(
          sectorId,
          sectorPump!.pumpId,
        );
      }
    }
  }
}


@Riverpod(keepAlive: true)
DismissSectorService dismissSectorService(DismissSectorServiceRef ref) {
  return DismissSectorService(ref);
}