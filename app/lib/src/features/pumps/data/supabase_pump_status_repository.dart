import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';

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
    // TODO: implement watchPumpStatus
    throw UnimplementedError();
  }
}