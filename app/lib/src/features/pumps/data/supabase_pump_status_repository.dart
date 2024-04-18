import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_status.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_status_database_keys.dart';
import 'package:irrigazione_iot/src/utils/supabase_extensions.dart';

class SupabasePumpStatusRepository implements PumpStatusRepository {
  const SupabasePumpStatusRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<void> togglePumpStatus(Pump pump, String status) {
    // TODO: implement togglePumpStatus
    throw UnimplementedError();
  }

  @override
  Stream<bool?> watchPumpStatus(Pump pump) {
    final stream = _supabaseClient.pumpStatus
        .stream(primaryKey: [PumpStatusDatabaseKeys.id])
        .eq(PumpStatusDatabaseKeys.pumpId, pump.id)
        .order(PumpStatusDatabaseKeys.createdAt, ascending: false)
        .limit(1);

    return stream.map((status) {
      if (status.isEmpty) return false;

      final statusObject = PumpStatus.fromJson(status.first);
      return statusObject.translatePumpStatusToBoolean(pump);
    });
  }
}
