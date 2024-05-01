import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_flow.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_flow_database_keys.dart';
import 'package:irrigazione_iot/src/utils/supabase_extensions.dart';

class SupabasePumpFlowRepository implements PumpFlowRepository {
  const SupabasePumpFlowRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Stream<int> watchTotalLitresDispensed(String pumpId) {
    final stream = _supabaseClient.pumpFlow
        .stream(primaryKey: [PumpFlowDatabaseKeys.id]).eq(
            PumpFlowDatabaseKeys.pumpId, pumpId);

    return stream.map((flows) {
      return flows.fold<int>(0, (total, flow) {
        final pumpFlow = PumpFlow.fromJson(flow);
        return total + pumpFlow.flow.toInt();
      });
    });
  }

  @override
  Stream<DateTime?> watchLastDispensation(String pumpId) {
    final stream = _supabaseClient.pumpFlow
        .stream(primaryKey: [PumpFlowDatabaseKeys.id])
        .eq(PumpFlowDatabaseKeys.pumpId, pumpId)
        .order(PumpFlowDatabaseKeys.createdAt, ascending: false).limit(1);

    return stream.map((flows) {
      if (flows.isEmpty) return null;
      final pumpFlow = PumpFlow.fromJson(flows.first);
      return pumpFlow.createdAt;
    });
  }
}
