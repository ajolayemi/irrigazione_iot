import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_sector.dart';

class SupabaseCollectorSectorRepository implements CollectorSectorRepository {
  const SupabaseCollectorSectorRepository(this._supabaseClient);

  final SupabaseClient _supabaseClient;
  
  @override
  Future<CollectorSector?> createCollectorSector(CollectorSector collectorSector) {
    // TODO: implement createCollectorSector
    throw UnimplementedError();
  }
  
  @override
  Future<bool> deleteCollectorSector(CollectorSector collectorSector) {
    // TODO: implement deleteCollectorSector
    throw UnimplementedError();
  }
  
  @override
  Future<List<CollectorSector?>> getCollectorSectorsById(String collectorId) {
    // TODO: implement getCollectorSectorsById
    throw UnimplementedError();
  }
  
  @override
  Stream<List<CollectorSector?>> watchCollectorSectorsById(String collectorId) {
    // TODO: implement watchCollectorSectorsById
    throw UnimplementedError();
  }

}
