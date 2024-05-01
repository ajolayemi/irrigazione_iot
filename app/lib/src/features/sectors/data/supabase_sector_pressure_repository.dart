import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/sectors/data/sector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pressure.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pressure_database_keys.dart';
import 'package:irrigazione_iot/src/utils/supabase_extensions.dart';

class SupabaseSectorPressureRepository implements SectorPressureRepository {
  const SupabaseSectorPressureRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;
  @override
  Stream<DateTime?> watchLastPressureReading(String sectorId) {
    final stream = _supabaseClient.sectorPressure
        .stream(primaryKey: [SectorPressureDatabaseKeys.id])
        .eq(SectorPressureDatabaseKeys.sectorId, sectorId)
        .order(SectorPressureDatabaseKeys.createdAt, ascending: false)
        .limit(1);

    return stream.map((pressures) {
      if (pressures.isEmpty) return null;
      final sectorPressure = SectorPressure.fromJson(pressures.first);
      return sectorPressure.createdAt;
    });
  }
}
