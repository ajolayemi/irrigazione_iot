import 'package:irrigazione_iot/src/features/dashboard/models/sector_switched_on.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/sector_switched_on_database_keys.dart';
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

  SupabaseStreamFilterBuilder get _sectorsSwitchedOnStream =>
      _supabaseClient.from(SectorSwitchedOnDatabaseKeys.table).stream(
        primaryKey: [SectorSwitchedOnDatabaseKeys.id],
      );

  List<PumpSwitchedOn>? convertToPumpSwitchedOnList(
      List<Map<String, dynamic>>? data) {
    if (data == null) return null;
    return data
        .map((e) => PumpSwitchedOn.fromJson(e))
        .where((e) => e.statusBoolean)
        .toList();
  }

  List<SectorSwitchedOn>? convertToSectorSwitchedOnList(
      List<Map<String, dynamic>>? data) {
    if (data == null) return null;
    return data
        .map((e) => SectorSwitchedOn.fromJson(e))
        .where((e) => e.statusBoolean)
        .toList();
  }

  @override
  Stream<List<PumpSwitchedOn>?> watchPumpsSwitchedOn(String companyId) {
    final res = _pumpsSwitchedOnStream.eq(
        PumpSwitchedOnDatabaseKeys.companyId, companyId);

    return res.map(convertToPumpSwitchedOnList);
  }

  @override
  Stream<List<SectorSwitchedOn>?> watchSectorsSwitchedOn(String companyId) {
    final res = _sectorsSwitchedOnStream.eq(
        SectorSwitchedOnDatabaseKeys.companyId, companyId);

    return res.map(convertToSectorSwitchedOnList);
  }
}
