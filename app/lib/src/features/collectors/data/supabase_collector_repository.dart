import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector_database_keys.dart';
import 'package:irrigazione_iot/src/shared/models/db_cud_bodies.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseCollectorRepository implements CollectorRepository {
  const SupabaseCollectorRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  List<Collector?> _collectorFromJsonList(List<Map<String, dynamic>>? data) {
    if (data == null) return [];
    return data.map((collector) => Collector.fromJson(collector)).toList();
  }

  Collector? _collectorFromJsonSingle(List<Map<String, dynamic>> data) {
    return data.isEmpty ? null : Collector.fromJson(data.first);
  }

  Collector? _toCollector(Map<String, dynamic>? data) {
    return data == null ? null : Collector.fromJson(data);
  }

  @override
  Future<Collector?> createCollector(Collector collector) async {
    final data = collector
        .copyWith(
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )
        .toJson();
    final res = await _supabaseClient.invokeFunction(
      functionName: 'insert-collector',
      body: InsertBody(
        data: data,
      ).toJson(),
    );
    return res.toObject<Collector>(Collector.fromJson);
  }

  @override
  Future<Collector?> updateCollector(Collector collector) async {
    final data = collector
        .copyWith(
          updatedAt: DateTime.now(),
        )
        .toJson();
    final res = await _supabaseClient.invokeFunction(
      functionName: 'update-collector',
      body: UpdateBody(
        id: collector.id,
        data: data,
      ).toJson(),
    );
    return res.toObject<Collector>(Collector.fromJson);
  }

  @override
  Future<bool> deleteCollector(String collectorID) async {
    final res = await _supabaseClient.invokeFunction(
      functionName: 'delete-collector',
      body: DeleteBody(ids: [collectorID]).toJson(),
    );
    return res.onDelete;
  }

  @override
  Stream<List<String?>> watchCompanyUsedCollectorNames(String companyId) {
    return watchCollectors(companyId).map((collectors) {
      return collectors
          .map((collector) => collector?.name.toLowerCase())
          .toList();
    });
  }

  @override
  Stream<Collector?> watchCollector(String collectorID) {
    final stream = _supabaseClient.collectorStream
        .eq(CollectorDatabaseKeys.id, collectorID);
    return stream.map(_collectorFromJsonSingle);
  }

  @override
  Stream<List<Collector?>> watchCollectors(String companyId) {
    final stream = _supabaseClient.collectorStream
        .eq(CollectorDatabaseKeys.companyId, companyId);
    return stream.map(_collectorFromJsonList);
  }

  @override
  Stream<List<String?>> watchCollectorUsedMqttMessageNames() {
    return _supabaseClient.collectorStream.map((collectors) => collectors
        .map(
          (collector) =>
              Collector.fromJson(collector).mqttMsgName.toLowerCase(),
        )
        .toList());
  }

  @override
  Future<Collector?> getCollector(String collectorId) async {
    final data = await _supabaseClient.collectors
        .select()
        .eq(CollectorDatabaseKeys.id, collectorId)
        .maybeSingle()
        .withConverter(_toCollector);
    return data;
  }
}
