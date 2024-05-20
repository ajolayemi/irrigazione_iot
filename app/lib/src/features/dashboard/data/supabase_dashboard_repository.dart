import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/dashboard/data/dashboard_repository.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/pump_switched_on.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/pump_switched_on_database_keys.dart';

class SupabaseDashboardRepository implements DashboardRepository {
  const SupabaseDashboardRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  SupabaseStreamFilterBuilder get _pumpsSwitchedOnStream =>
      _supabaseClient.from(PumpSwitchedOnDatabaseKeys.table).stream(
        primaryKey: [PumpSwitchedOnDatabaseKeys.id],
      );

  List<PumpSwitchedOn>? convertToPumpSwitchedOnList(
      List<Map<String, dynamic>>? data) {
    if (data == null) return null;
    return data
        .map((e) => PumpSwitchedOn.fromJson(e))
        .where((el) => el.statusBoolean)
        .toList();
  }

  @override
  Stream<List<PumpSwitchedOn>?> watchPumpsSwitchedOn(String companyId) {
    final res = _pumpsSwitchedOnStream.eq(
        PumpSwitchedOnDatabaseKeys.companyId, companyId);

    return res.map(convertToPumpSwitchedOnList);
  }
}
