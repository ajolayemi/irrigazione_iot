import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_status.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_status_database_keys.dart';
import 'package:irrigazione_iot/src/shared/models/item_status_request.dart';
import 'package:irrigazione_iot/src/shared/services/mqtt_client_service.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseSectorStatusRepository implements SectorStatusRepository {
  const SupabaseSectorStatusRepository(
    this._supabaseClient,
    this._mqttService,
  );
  final SupabaseClient _supabaseClient;
  final MqttClientService _mqttService;

  @override
  Future<void> toggleSectorStatus({
    required ItemStatusRequest statusBody,
  }) async {
    final mqttClient = await _mqttService.connect();

    await _mqttService.publishMessage(
      mqttClient,
      statusBody.topic,
      statusBody.toJson(),
    );

    return;
  }

  @override
  Stream<SectorStatus?> watchSectorStatus(String sectorId) {
    final stream = _supabaseClient.sectorStatus
        .stream(primaryKey: [SectorStatusDatabaseKeys.id])
        .eq(SectorStatusDatabaseKeys.sectorId, sectorId)
        .order(SectorStatusDatabaseKeys.createdAt, ascending: false)
        .limit(1);

    return stream.map((statuses) {
      if (statuses.isEmpty) return null;
      return SectorStatus.fromJson(statuses.first);
    });
  }
}
