import 'package:irrigazione_iot/src/shared/models/rpc_parameter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_pump.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_pump_database_keys.dart';
import 'package:irrigazione_iot/src/shared/models/db_cud_bodies.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseSectorPumpRepository implements SectorPumpRepository {
  const SupabaseSectorPumpRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  SectorPump? _sectorPumpFromJson(Map<String, dynamic>? data) =>
      data == null ? null : SectorPump.fromJson(data);

  SectorPump? _sectorPumpSingleFromJson(List<Map<String, dynamic>> data) =>
      data.isEmpty ? null : SectorPump.fromJson(data.first);

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
  Future<SectorPump?> getSectorPump(String sectorId) =>
      _supabaseClient.selectedSectorPumps
          .eq(SectorPumpDatabaseKeys.sectorId, sectorId)
          .maybeSingle()
          .withConverter(_sectorPumpFromJson);

  @override
  Stream<SectorPump?> watchSectorPump(String sectorId) {
    final stream = _supabaseClient.sectorPump
        .stream(primaryKey: [SectorPumpDatabaseKeys.id])
        .eq(
          SectorPumpDatabaseKeys.sectorId,
          sectorId,
        )
        .limit(1);

    return stream.map(_sectorPumpSingleFromJson);
  }

  @override
  Future<List<Pump>?> getAvailablePumps({
    required String companyId,
    String? alreadyConnectedPumpId,
  }) async {
    final rpcParam = RpcParameters(
            companyId: companyId,
            idAlreadyConnected: alreadyConnectedPumpId?.isEmpty ?? false
                ? null
                : alreadyConnectedPumpId)
        .toJson();

    return await _supabaseClient
        .rpc<List<Map<String, dynamic>>>(
      'get_pumps_not_connected_to_sector',
      params: rpcParam,
    )
        .withConverter((pumps) {
      if (pumps.isEmpty) return null;
      final res = pumps.map((pump) => Pump.fromJson(pump)).toList();
      res.sort((a, b) => a.name.compareTo(b.name));
      return res;
    });
  }
}
