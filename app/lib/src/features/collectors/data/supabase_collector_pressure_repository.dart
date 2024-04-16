import 'package:irrigazione_iot/src/features/collectors/data/collector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_pressure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCollectorPressureRepository implements CollectorPressureRepository {

  const SupabaseCollectorPressureRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<CollectorPressure?> getCollectorPressure({required String collectorId}) {
    // TODO: implement getCollectorPressure
    throw UnimplementedError();
  }

  @override
  Stream<CollectorPressure?> watchCollectorPressure({required String collectorId}) {
    // TODO: implement watchCollectorPressure
    throw UnimplementedError();
  }
}
