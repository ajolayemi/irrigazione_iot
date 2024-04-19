import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pump.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pump_database_keys.dart';
import 'package:irrigazione_iot/src/shared/models/db_cud_bodies.dart';
import 'package:irrigazione_iot/src/utils/supabase_extensions.dart';

class SupabaseSectorPumpRepository implements SectorPumpRepository {
  const SupabaseSectorPumpRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  List<SectorPump?> _sectorPumpsFromJsonList(List<Map<String, dynamic>> data) {
    return data.map((sectorPump) => SectorPump.fromJson(sectorPump)).toList();
  }

  @override
  Future<SectorPump?> createSectorPump(SectorPump sectorPump) async {
    // set the created_at
    final data = sectorPump.copyWith(createdAt: DateTime.now()).toJson();
    final res = await _supabaseClient.invokeFunction(
      functionName: 'insert-sector-pump',
      body: InsertBody(data: data).toJson(),
    );
    return res.toObject<SectorPump>(SectorPump.fromJson);
  }

  @override
  Future<bool> deleteSectorPump(String sectorIdPumpId) async {
    final res = await _supabaseClient.invokeFunction(
      functionName: 'delete-sector-pump',
      body: DeleteBody(ids: [sectorIdPumpId]).toJson(),
    );
    return res.onDelete;
  }

  @override
  Future<List<SectorPump?>> getSectorPumps(String sectorId) =>
      _supabaseClient.selectedSectorPumps
          .eq(SectorPumpDatabaseKeys.sectorId, sectorId)
          .withConverter(_sectorPumpsFromJsonList);

  @override
  Stream<List<SectorPump?>> watchSectorPumps(String sectorId) {
    final stream = _supabaseClient.sectorPump
        .stream(primaryKey: [SectorPumpDatabaseKeys.id]).eq(
      SectorPumpDatabaseKeys.sectorId,
      sectorId,
    );

    return stream.map(_sectorPumpsFromJsonList);
  }
}
