import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCollectorRepository implements CollectorRepository {
  const SupabaseCollectorRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<Collector?> addCollector(Collector collector, String companyId) {
    // TODO: implement addCollector
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteCollector(String collectorID) {
    // TODO: implement deleteCollector
    throw UnimplementedError();
  }

  @override
  Future<Collector?> getCollector(String collectorID) {
    // TODO: implement getCollector
    throw UnimplementedError();
  }

  @override
  Future<List<Collector?>> getCollectors(String companyId) {
    // TODO: implement getCollectors
    throw UnimplementedError();
  }

  @override
  Future<Collector?> updateCollector(Collector collector, String companyId) {
    // TODO: implement updateCollector
    throw UnimplementedError();
  }

  @override
  Stream<Collector?> watchCollector(String collectorID) {
    // TODO: implement watchCollector
    throw UnimplementedError();
  }

  @override
  Stream<double?> watchCollectorBatteryLevel(String collectorID) {
    // TODO: implement watchCollectorBatteryLevel
    throw UnimplementedError();
  }

  @override
  Stream<List<Collector?>> watchCollectors(String companyId) {
    // TODO: implement watchCollectors
    throw UnimplementedError();
  }

  @override
  Stream<List<String?>> watchCompanyUsedCollectorNames(String companyId) {
    // TODO: implement watchCompanyUsedCollectorNames
    throw UnimplementedError();
  }

  
}