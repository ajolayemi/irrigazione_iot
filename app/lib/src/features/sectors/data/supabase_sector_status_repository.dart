import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';

class SupabaseSectorStatusRepository implements SectorStatusRepository {

  const SupabaseSectorStatusRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<DateTime?> getSectorLastIrrigation(Sector sector) {
    // TODO: implement getSectorLastIrrigation
    throw UnimplementedError();
  }

  @override
  Future<bool?> getSectorStatus(Sector sector) {
    // TODO: implement getSectorStatus
    throw UnimplementedError();
  }

  @override
  Future<void> toggleSectorStatus(Sector sector, String status) {
    // TODO: implement toggleSectorStatus
    throw UnimplementedError();
  }

  @override
  Stream<DateTime?> watchSectorLastIrrigation(Sector sector) {
    // TODO: implement watchSectorLastIrrigation
    throw UnimplementedError();
  }

  @override
  Stream<bool?> watchSectorStatus(Sector sector) {
    // TODO: implement watchSectorStatus
    throw UnimplementedError();
  }
}