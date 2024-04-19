import 'package:irrigazione_iot/src/features/sectors/data/sector_pressure_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSectorPressureRepository implements SectorPressureRepository {
  const SupabaseSectorPressureRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;
  @override
  Stream<DateTime?> watchLastPressureReading(String sectorId) {
    // TODO: implement watchLastPressureReading
    throw UnimplementedError();
  }
}
