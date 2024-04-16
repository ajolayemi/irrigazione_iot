import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pump.dart';

class SupabaseSectorPumpRepository implements SectorPumpRepository {
  const SupabaseSectorPumpRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<SectorPump?> addSectorPump(SectorPump sectorPump) {
    // TODO: implement addSectorPump
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteSectorPump(String sectorId, String pumpId) {
    // TODO: implement deleteSectorPump
    throw UnimplementedError();
  }

  @override
  Future<List<SectorPump?>> getSectorPumps(String sectorId) {
    // TODO: implement getSectorPumps
    throw UnimplementedError();
  }

  @override
  Stream<List<SectorPump?>> watchSectorPumps(String sectorId) {
    // TODO: implement watchSectorPumps
    throw UnimplementedError();
  }
}
