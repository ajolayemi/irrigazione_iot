import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/config/data/mqtt_topics_suffix.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/shared/models/firebase_callable_function_body.dart';

part 'sector_status_service.g.dart';

class SectorStatusService {
  SectorStatusService(this._ref);
  final Ref _ref;

  Future<void> toggleStatus(
      {required Sector sector, required bool status}) async {
    final authRepo = _ref.read(authRepositoryProvider);
    final uid = authRepo.currentUser?.uid;

    if (uid == null) return;

    final selectedCompanyRepo = _ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(uid);

    if (companyId == null) return;

    final companyRepo = _ref.read(companyRepositoryProvider);
    final company = await companyRepo.fetchCompany(companyId);

    if (company == null) return;

    final collectorSectorRepo = _ref.read(collectorSectorRepositoryProvider);
    // Get the collector that the current sector is connected to
    final collector =
        await collectorSectorRepo.getCollectorBySectorId(sector.id);

    if (collector == null) return;

    final companyMqttTopicName = company.mqttTopicName;
    final statusCommand = sector.getMqttStatusCommand(status);

    final sectorStatusRepo = _ref.read(sectorStatusRepositoryProvider);

    final mqttSuffix = _ref.read(mqttTopicsSuffixProvider);

    final body = FirebaseCallableFunctionBody(
      topic:
          '$companyMqttTopicName/collettore${collector.mqttMsgName}/${mqttSuffix.sectorStatusToggle}',
      message: statusCommand,
      mqttMsgName: sector.mqttMsgName,
      msgBoolVersion: status,
      isSector: true,
    );

    await sectorStatusRepo.toggleSectorStatus(statusBody: body);
  }
}

@Riverpod(keepAlive: true)
SectorStatusService sectorStatusService(SectorStatusServiceRef ref) {
  return SectorStatusService(ref);
}
