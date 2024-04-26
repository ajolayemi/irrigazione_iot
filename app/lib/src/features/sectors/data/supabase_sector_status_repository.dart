import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_status.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_status_database_keys.dart';
import 'package:irrigazione_iot/src/utils/supabase_extensions.dart';

class SupabaseSectorStatusRepository implements SectorStatusRepository {
  const SupabaseSectorStatusRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<void> toggleSectorStatus(
      {required String sectorId,
      required String statusString,
      required bool statusBoolean}) {
    // TODO: implement toggleSectorStatus
    throw UnimplementedError();
  }

  @override
  Stream<bool?> watchSectorStatus(String sectorId) {
    final stream = _supabaseClient.sectorStatus
        .stream(primaryKey: [SectorStatusDatabaseKeys.id])
        .eq(SectorStatusDatabaseKeys.sectorId, sectorId)
        .order(SectorStatusDatabaseKeys.createdAt, ascending: false)
        .limit(1);

    return stream.map((statuses) {
      if (statuses.isEmpty) return false;
      final status = SectorStatus.fromJson(statuses.first);
      return status.statusBoolean;
    });
  }
}
