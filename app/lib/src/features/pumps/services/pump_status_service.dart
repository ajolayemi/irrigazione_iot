import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/config/data/mqtt_configs.dart';
import 'package:irrigazione_iot/src/config/enums/mqtt_enums.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/shared/models/item_status_request.dart';
import 'package:irrigazione_iot/src/utils/app_utils.dart';

part 'pump_status_service.g.dart';

class PumpStatusService {
  const PumpStatusService(
    this._ref,
  );
  final Ref _ref;

  Future<void> toggleStatus({
    required Pump pump,
    required bool status,
  }) async {
    final authRepo = _ref.read(authRepositoryProvider);
    final uid = authRepo.currentUser?.uid;

    if (uid == null) return;
    final selectedCompanyRepo = _ref.read(selectedCompanyRepositoryProvider);

    final companyId = selectedCompanyRepo.loadSelectedCompanyId(uid);

    if (companyId == null) return;

    final companyRepo = _ref.read(companyRepositoryProvider);
    final company = await companyRepo.fetchCompany(companyId);

    if (company == null) return;

    final companyMqttTopicName = company.mqttTopicName;
    final statusCommand = pump.getStatusCommand(status);

    final pumpStatusRepo = _ref.read(pumpStatusRepositoryProvider);

    final mqttConfigs = _ref.read(mqttConfigsProvider);

    final topics = [
      '$companyMqttTopicName/${mqttConfigs.pumpStatusToggle}',
      AppUtils.buildFullMqttTopic(
        companyName: companyMqttTopicName,
        msgType: AppMqttMessageTypes.pumpStatus,
      ),
    ];

    final body = ItemStatusRequest(
      message: statusCommand,
      mqttMsgName: pump.mqttMessageName,
      messageType: 'pump_status',
      itemId: pump.id,
      companyId: companyId,
      statusBoolean: statusCommand == pump.turnOnCommand,
      createdAt: DateTime.now(),
    );

    await pumpStatusRepo.togglePumpStatus(
      mqttBody: body,
      topicsToPublishTo: topics,
    );
  }
}

@Riverpod(keepAlive: true)
PumpStatusService pumpStatusService(PumpStatusServiceRef ref) {
  return PumpStatusService(ref);
}
