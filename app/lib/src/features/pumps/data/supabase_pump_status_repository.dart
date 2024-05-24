import 'package:irrigazione_iot/src/shared/services/mqtt_client_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status_database_keys.dart';
import 'package:irrigazione_iot/src/shared/models/item_status_request.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabasePumpStatusRepository implements PumpStatusRepository {
  const SupabasePumpStatusRepository(
    this._supabaseClient,
    this._mqttService,
  );
  final SupabaseClient _supabaseClient;
  final MqttClientService _mqttService;

  @override
  Future<void> togglePumpStatus({
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
  Stream<PumpStatus?> watchPumpStatus(String pumpId) {
    final stream = _supabaseClient.pumpStatus
        .stream(primaryKey: [PumpStatusDatabaseKeys.id])
        .eq(PumpStatusDatabaseKeys.pumpId, pumpId)
        .order(PumpStatusDatabaseKeys.createdAt, ascending: false)
        .limit(1);

    return stream.map((status) {
      if (status.isEmpty) return null;

      return PumpStatus.fromJson(status.first);
    });
  }
}
