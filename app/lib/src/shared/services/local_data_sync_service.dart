import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/data/datasource/dao/mqtt_dao.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_statistic_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_status.dart';
import 'package:irrigazione_iot/src/features/terminal/data/terminal_pressure_repository.dart';

part 'local_data_sync_service.g.dart';

/// Holds onto the logic to sync server data to local storage when app is being started
/// and when the app is resumed.
class LocalDataSyncService {
  final Ref _ref;
  final MqttDao _mqttDao;
  final String? selectedCompanyId;

  const LocalDataSyncService(this._mqttDao, this._ref, this.selectedCompanyId);

  /// Syncs the server data to local storage.
  /// This is done when the app is being started and when the app is resumed.
  /// The data is synced to local storage using the [MqttDao] class.
  Future<void> syncServerDataToLocalStorage() async {
    String? companyId = selectedCompanyId;
    final pumpStatusRepo = _ref.read(pumpStatusRepositoryProvider);
    final sectorStatusRepo = _ref.read(sectorStatusRepositoryProvider);
    final pumpPressureRepo = _ref.read(pumpStatisticRepositoryProvider);
    final pumpFlowRepo = _ref.read(pumpFlowRepositoryProvider);
    final sectorPressureRepo = _ref.read(sectorPressureRepositoryProvider);
    final collectorPressureRepo =
        _ref.read(collectorPressureRepositoryProvider);
    final terminalPressureRepo = _ref.read(terminalPressureRepositoryProvider);
    try {
      if (companyId == null || companyId.isEmpty == true) {
        return;
      }
      // Clear the local storage
      await _mqttDao.clearMqttDao();

      // Fetch all necessary server data and save them to local database

      /* Pump Statuses */
      final pumpStatuses = await pumpStatusRepo.getLatestPumpStatuses(
        companyId,
      );
      if (pumpStatuses != null && pumpStatuses.isNotEmpty) {
        await _mqttDao.insertPumpStatuses(statuses: pumpStatuses);
        await _mqttDao.insertPumpsSwitchedOn(
          data: pumpStatuses.toPumpsSwitchedOn(),
        );
      }

      /* Sector Statuses */
      final sectorStatuses = await sectorStatusRepo.getLatestSectorStatuses(
        companyId,
      );

      if (sectorStatuses != null && sectorStatuses.isNotEmpty) {
        await _mqttDao.insertSectorStatuses(statuses: sectorStatuses);
        await _mqttDao.insertSectorsSwitchedOn(
          data: sectorStatuses.toSectorsSwitchedOn(),
        );
      }

      /* Pump Pressures */
      final pPressures = await pumpPressureRepo.getLatestPumpPressures();

      if (pPressures != null && pPressures.isNotEmpty) {
        await _mqttDao.insertPumpPressures(data: pPressures);
      }

      /* Pump Flows */
      final pFlows = await pumpFlowRepo.getLatestPumpFlow();

      if (pFlows != null && pFlows.isNotEmpty) {
        await _mqttDao.insertPumpFlows(data: pFlows);
      }

      /* Sector Pressures */
      final sPressures = await sectorPressureRepo.getLatestSectorPressure();
      if (sPressures != null && sPressures.isNotEmpty) {
        await _mqttDao.insertSectorPressures(data: sPressures);
      }

      /* Collector Pressures */
      final cPressures =
          await collectorPressureRepo.getLatestCollectorPressure();
      if (cPressures != null && cPressures.isNotEmpty) {
        await _mqttDao.insertCollectorPressures(data: cPressures);
      }

      /* Terminal Pressures */
      final tPressures = await terminalPressureRepo.getLatestTerminalPressure();
      if (tPressures != null && tPressures.isNotEmpty) {
        await _mqttDao.insertTerminalPressures(data: tPressures);
      }
    } catch (e) {
      debugPrint('Error occurred');
    }
  }
}

@Riverpod(keepAlive: true)
LocalDataSyncService localSyncService(LocalSyncServiceRef ref) {
  final mqttDao = ref.watch(mqttDaoProvider);
  // TODO: [Kehinde] - remove hardcoded company id
  final companyId = ref.watch(tappedCompanyIdProvider).valueOrNull;
  return LocalDataSyncService(mqttDao, ref, '3');
}
