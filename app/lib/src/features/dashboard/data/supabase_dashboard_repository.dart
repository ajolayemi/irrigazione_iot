import 'package:irrigazione_iot/src/features/dashboard/models/pump_switched_on_database_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/dashboard/data/dashboard_repository.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/pump_statuses_stat.dart';

class SupabaseDashboardRepository implements DashboardRepository {
  const SupabaseDashboardRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  SupabaseStreamFilterBuilder get _pumpsSwitchedOnStream =>
      _supabaseClient.from(PumpStatusesStatDatabaseKeys.table).stream(
        primaryKey: [PumpStatusesStatDatabaseKeys.id],
      );

  List<PumpStatusesStat>? convertToPumpSwitchedOnList(
      List<Map<String, dynamic>>? data) {
    if (data == null) return null;
    return data
        .map((e) => PumpStatusesStat.fromJson(e))
        .where((el) => el.statusBoolean)
        .toList();
  }

  @override
  Stream<List<PumpStatusesStat>?> watchPumpsStatusesStats(String companyId) {
    final res = _pumpsSwitchedOnStream.eq(
        PumpStatusesStatDatabaseKeys.companyId, companyId);

    return res.map(convertToPumpSwitchedOnList);
  }
}
