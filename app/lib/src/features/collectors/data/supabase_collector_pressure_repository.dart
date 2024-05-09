import 'package:irrigazione_iot/src/features/collectors/data/collector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector_pressure.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector_pressure_database_keys.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCollectorPressureRepository
    implements CollectorPressureRepository {
  const SupabaseCollectorPressureRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Stream<CollectorPressure?> watchCollectorPressure(String collectorId) {
    final stream = _supabaseClient.collectorPressures
        .stream(primaryKey: [CollectorPressureDatabaseKeys.id])
        .eq(CollectorPressureDatabaseKeys.collectorId, collectorId)
        .order(CollectorPressureDatabaseKeys.createdAt, ascending: false)
        .limit(1);

    return stream.map((data) {
      if (data.isEmpty) return null;
      return CollectorPressure.fromJson(data.first);
    });
  }
}
