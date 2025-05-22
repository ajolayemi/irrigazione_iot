import 'package:irrigazione_iot/src/shared/models/rpc_parameter.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_status.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_status_database_keys.dart';
import 'package:irrigazione_iot/src/shared/models/item_status_request.dart';
import 'package:irrigazione_iot/src/shared/services/mqtt_client_service.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseSectorStatusRepository implements SectorStatusRepository {
  const SupabaseSectorStatusRepository({
    required this.supabaseClient,
    required this.mqttService,
    this.mqttClient,
  });
  final SupabaseClient supabaseClient;
  final MqttService mqttService;
  final MqttServerClient? mqttClient;

  @override
  Future<void> toggleSectorStatus(
      {required ItemStatusRequest statusBody}) async {
    await mqttService.publishMessage(
      topic: statusBody.topic,
      message: statusBody.toJson(),
      client: mqttClient,
    );

    return;
  }

  @override
  Stream<SectorStatus?> watchSectorStatus(String sectorId) {
    final stream = supabaseClient.sectorStatus
        .stream(primaryKey: [SectorStatusDatabaseKeys.id])
        .eq(SectorStatusDatabaseKeys.sectorId, sectorId)
        .order(SectorStatusDatabaseKeys.createdAt, ascending: false)
        .limit(1);

    return stream.map((statuses) {
      if (statuses.isEmpty) return null;
      return SectorStatus.fromJson(statuses.first);
    });
  }

  @override
  Future<List<SectorStatus>?> getLatestSectorStatuses(String companyId) async {
    final rpcParam = RpcCompanyIdParameter(companyId: companyId).toJson();
    return supabaseClient
        .rpc<List<Map<String, dynamic>>>(
      'latest_sector_status_data',
      params: rpcParam,
    )
        .withConverter(
      (data) {
        if (data.isEmpty) return null;

        return data.map((item) => SectorStatus.fromJson(item)).toList();
      },
    );
  }
}
