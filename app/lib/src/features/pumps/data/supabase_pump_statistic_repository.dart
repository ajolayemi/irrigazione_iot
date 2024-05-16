import 'package:irrigazione_iot/src/features/pumps/data/pump_statistic_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_pressure.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_pressure_database_keys.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePumpStatisticRepository implements PumpStatisticRepository {
  const SupabasePumpStatisticRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;
  @override
  Stream<PumpPressure?> watchLastPumpPressure(String pumpId) {
    final stream = _supabaseClient.pumpPressuresStream
        .eq(PumpPressureDatabaseKeys.pumpId, pumpId)
        .order(PumpPressureDatabaseKeys.createdAt, ascending: false)
        .limit(1);

    return stream.map((pressures) {
      if (pressures.isEmpty) return null;
      final pumpPressure = PumpPressure.fromJson(
        pressures.first,
      );
      return pumpPressure;
    });
  }
}
