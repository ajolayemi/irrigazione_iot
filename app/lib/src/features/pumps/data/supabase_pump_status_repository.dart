import 'package:cloud_functions/cloud_functions.dart';
import 'package:irrigazione_iot/src/constants/firebase_funcs_constants.dart';
import 'package:irrigazione_iot/src/shared/models/firebase_callable_function_body.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_status.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_status_database_keys.dart';
import 'package:irrigazione_iot/src/utils/supabase_extensions.dart';

class SupabasePumpStatusRepository implements PumpStatusRepository {
  const SupabasePumpStatusRepository(
    this._supabaseClient,
    this._firebaseFunctions,
  );
  final SupabaseClient _supabaseClient;
  final FirebaseFunctions _firebaseFunctions;

  @override
  Future<void> togglePumpStatus({
    required String pumpId,
    required bool statusBoolean,
    required FirebaseCallableFunctionBody statusBody,
  }) =>
      _firebaseFunctions
          .httpsCallable(FirebaseFunctionsConstants.toggleItemStatusFuncName)
          .call(statusBody.toJson());

  @override
  Stream<bool?> watchPumpStatus(String pumpId) {
    final stream = _supabaseClient.pumpStatus
        .stream(primaryKey: [PumpStatusDatabaseKeys.id])
        .eq(PumpStatusDatabaseKeys.pumpId, pumpId)
        .order(PumpStatusDatabaseKeys.createdAt, ascending: false)
        .limit(1);

    return stream.map((status) {
      if (status.isEmpty) return false;

      return PumpStatus.fromJson(status.first).statusBoolean;
    });
  }
}
