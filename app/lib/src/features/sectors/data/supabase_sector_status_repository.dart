import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_status.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_status_database_keys.dart';
import 'package:irrigazione_iot/src/utils/supabase_extensions.dart';

class SupabaseSectorStatusRepository implements SectorStatusRepository {
  const SupabaseSectorStatusRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<void> toggleSectorStatus(Sector sector, String status) {
    // TODO: implement toggleSectorStatus
    throw UnimplementedError();
  }

  @override
  Stream<bool?> watchSectorStatus(Sector sector) {
    final stream = _supabaseClient.sectorStatus
        .stream(primaryKey: [SectorStatusDatabaseKeys.id])
        .eq(SectorStatusDatabaseKeys.sectorId, sector.id)
        .order(SectorStatusDatabaseKeys.createdAt, ascending: false)
        .limit(1);

    return stream.map((statuses) {
      if (statuses.isEmpty) return false;
      final status = SectorStatus.fromJson(statuses.first);
      return status.translateSectorStatusToBoolean(sector);
    });
  }
}
