import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_database_keys.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_sector.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_sector_database_keys.dart';
import 'package:irrigazione_iot/src/shared/models/db_cud_bodies.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseCollectorSectorRepository implements CollectorSectorRepository {
  const SupabaseCollectorSectorRepository(this._supabaseClient);

  final SupabaseClient _supabaseClient;

  List<CollectorSector> _collectorSectorFromList(
      List<Map<String, dynamic>>? data) {
    if (data == null) return [];
    return data
        .map((collectorSector) => CollectorSector.fromJson(collectorSector))
        .toList();
  }

  @override
  Future<CollectorSector?> createCollectorSector(
    CollectorSector collectorSector,
  ) async {
    final data = collectorSector
        .copyWith(
          createdAt: DateTime.now(),
        )
        .toJson();

    final res = await _supabaseClient.invokeFunction(
        functionName: 'insert-collector-sector',
        body: InsertBody(data: data).toJson());

    return res.toObject<CollectorSector>(CollectorSector.fromJson);
  }

  @override
  Future<bool> deleteCollectorSector(String collectorSectorId) async {
    final res = await _supabaseClient.invokeFunction(
      functionName: 'delete-collector-sector',
      body: DeleteBody(ids: [collectorSectorId]).toJson(),
    );
    return res.onDelete;
  }

  @override
  Future<List<CollectorSector?>> getCollectorSectorsById(String collectorId) =>
      _supabaseClient.collectorSectors
          .select()
          .eq(CollectorSectorDatabaseKeys.collectorId, collectorId)
          .withConverter(_collectorSectorFromList);

  @override
  Future<Collector?> getCollectorBySectorId(String sectorId) async {
    final data = await _supabaseClient.collectorSectors
        .select(
          '''${CollectorDatabaseKeys.table}: ${CollectorSectorDatabaseKeys.collectorId} (*)''',
        )
        .eq(
          CollectorSectorDatabaseKeys.sectorId,
          sectorId,
        )
        .maybeSingle();

    if (data == null || data.isEmpty || !data.keys.contains('collectors')) {
      return null;
    }
    return Collector.fromJson(data['collectors']);
  }

  @override
  Stream<List<CollectorSector?>> watchCollectorSectorsById(String collectorId) {
    final stream = _supabaseClient.collectorSectorsStream.eq(
      CollectorSectorDatabaseKeys.collectorId,
      collectorId,
    );

    return stream.map(_collectorSectorFromList);
  }
}
