import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';

class SupabasePumpFlowRepository implements PumpFlowRepository {
  const SupabasePumpFlowRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Stream<int> watchTotalLitresDispensed(Pump pump) {
    // TODO: implement watchTotalLitresDispensed
    throw UnimplementedError();
  }
}
