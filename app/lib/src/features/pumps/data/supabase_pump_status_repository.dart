import 'package:cloud_functions/cloud_functions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_status.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_status_database_keys.dart';
import 'package:irrigazione_iot/src/utils/supabase_extensions.dart';

class SupabasePumpStatusRepository implements PumpStatusRepository {
  const SupabasePumpStatusRepository(
    this._supabaseClient,
    this._firebaseFunctions,
  );
  final SupabaseClient _supabaseClient;
  final FirebaseFunctions _firebaseFunctions;

  @override
  Future<void> togglePumpStatus({
    required String pumpId,
    required String statusString,
    required bool statusBoolean,
    required String companyMqttTopicName
  }) async {
    print('togglePumpStatus');
    final callable = _firebaseFunctions.httpsCallable('toggleItemStatus');
    await callable.call({
      'topic': 'valenziani/cm',
      'message': statusString,
    });
  }

  @override
  Stream<bool?> watchPumpStatus(String pumpId) {
    final stream = _supabaseClient.pumpStatus
        .stream(primaryKey: [PumpStatusDatabaseKeys.id])
        .eq(PumpStatusDatabaseKeys.pumpId, pumpId)
        .order(PumpStatusDatabaseKeys.createdAt, ascending: false)
        .limit(1);

    return stream.map((status) {
      if (status.isEmpty) return false;

      return PumpStatus.fromJson(status.first).statusBoolean;
    });
  }
}
