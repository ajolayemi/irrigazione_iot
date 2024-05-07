import 'package:cloud_functions/cloud_functions.dart';
import 'package:irrigazione_iot/src/constants/firebase_funcs_constants.dart';
import 'package:irrigazione_iot/src/shared/models/firebase_callable_function_body.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_status.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_status_database_keys.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseSectorStatusRepository implements SectorStatusRepository {
  const SupabaseSectorStatusRepository(this._supabaseClient, this._firebaseFunctions,);
  final SupabaseClient _supabaseClient;
  final FirebaseFunctions _firebaseFunctions;

  @override
  Future<void> toggleSectorStatus(
     {
    required FirebaseCallableFunctionBody statusBody,
  }) =>  _firebaseFunctions
      .httpsCallable(FirebaseFunctionsConstants.toggleItemStatusFuncName)
      .call(statusBody.toJson());

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
