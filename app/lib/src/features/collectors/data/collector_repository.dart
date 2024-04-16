import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/collectors/data/supabase_collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'collector_repository.g.dart';

abstract class CollectorRepository {
  /// returns a list of [Collector] pertaining to a company if any
  Future<List<Collector?>> getCollectors(String companyId);

  /// emits a list of [Collector] pertaining to a company if any
  Stream<List<Collector?>> watchCollectors(String companyId);

  /// emits a [Collector] with the given collectorID
  Stream<Collector?> watchCollector(String collectorID);

  /// returns a [Collector] with the given collectorID
  Future<Collector?> getCollector(String collectorID);

  /// adds a [Collector]
  Future<Collector?> addCollector(Collector collector, String companyId);

  /// updates a [Collector]
  Future<Collector?> updateCollector(Collector collector, String companyId);

  /// deletes a [Collector]
  Future<bool> deleteCollector(String collectorID);

  /// emits a list of already used collector names for a specified company
  /// this is used in form validation to prevent duplicate collector names for a company
  Stream<List<String?>> watchCompanyUsedCollectorNames(String companyId);

  /// emits the most recent battery level for the collector
  /// this is used to display the battery level in the UI
  Stream<double?> watchCollectorBatteryLevel(String collectorID);
}

@Riverpod(keepAlive: true)
CollectorRepository collectorRepository(CollectorRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseCollectorRepository(supabaseClient);
}

@riverpod
Stream<List<Collector?>> collectorListStream(CollectorListStreamRef ref) {
  final collectorRepository = ref.read(collectorRepositoryProvider);
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return const Stream.empty();
  return collectorRepository.watchCollectors(companyId);
}

@riverpod
Future<List<Collector?>> collectorListFuture(CollectorListFutureRef ref) {
  final collectorRepository = ref.read(collectorRepositoryProvider);
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return Future.value([]);
  return collectorRepository.getCollectors(companyId);
}

@riverpod
Stream<List<String?>> usedCollectorNamesStream(
    UsedCollectorNamesStreamRef ref) {
  final collectorRepository = ref.read(collectorRepositoryProvider);
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return const Stream.empty();
  return collectorRepository.watchCompanyUsedCollectorNames(companyId);
}

/// Watches a single instance of [Collector] as specified by [String]
@riverpod
Stream<Collector?> collectorStream(CollectorStreamRef ref, String collectorId) {
  final collectorRepository = ref.watch(collectorRepositoryProvider);
  return collectorRepository.watchCollector(collectorId);
}

/// Gets a single instance of [Collector] as specified by [String]
@riverpod
Future<Collector?> collectorFuture(CollectorFutureRef ref, String collectorId) {
  final collectorRepository = ref.watch(collectorRepositoryProvider);
  return collectorRepository.getCollector(collectorId);
}

@riverpod
Stream<double?> collectorBatteryLevelStream(CollectorBatteryLevelStreamRef ref,
    {required String collectorId}) {
  final collectorRepository = ref.watch(collectorRepositoryProvider);
  return collectorRepository.watchCollectorBatteryLevel(collectorId);
}
