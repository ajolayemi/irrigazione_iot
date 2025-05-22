import 'package:irrigazione_iot/src/shared/models/rpc_parameter.dart';
import 'package:irrigazione_iot/src/shared/services/mqtt_client_service.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status_database_keys.dart';
import 'package:irrigazione_iot/src/shared/models/item_status_request.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabasePumpStatusRepository implements PumpStatusRepository {
  const SupabasePumpStatusRepository({
    required this.supabaseClient,
    required this.mqttService,
    this.mqttClient,
  });
  final SupabaseClient supabaseClient;
  final MqttServerClient? mqttClient;
  final MqttService mqttService;

  @override
  Future<void> togglePumpStatus({required ItemStatusRequest statusBody}) async {
    await mqttService.publishMessage(
      topic: statusBody.topic,
      message: statusBody.toJson(),
      client: mqttClient,
    );

    return;
  }

  @override
  Stream<PumpStatus?> watchPumpStatus(String pumpId) {
    final stream = supabaseClient.pumpStatus
        .stream(primaryKey: [PumpStatusDatabaseKeys.id])
        .eq(PumpStatusDatabaseKeys.pumpId, pumpId)
        .order(PumpStatusDatabaseKeys.createdAt, ascending: false)
        .limit(1);

    return stream.map((status) {
      if (status.isEmpty) return null;

      return PumpStatus.fromJson(status.first);
    });
  }

  @override
  Future<List<PumpStatus>?> getLatestPumpStatuses(String companyId) async {
    final rpcParam = RpcCompanyIdParameter(companyId: companyId).toJson();

    return supabaseClient
        .rpc<List<Map<String, dynamic>>>(
      'latest_pump_status_data',
      params: rpcParam,
    )
        .withConverter((statuses) {
      if (statuses.isEmpty) return null;

      return statuses.map((item) => PumpStatus.fromJson(item)).toList();
    });
  }
}
