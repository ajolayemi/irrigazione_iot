import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/collectors/data/supabase_collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'collector_repository.g.dart';

abstract class CollectorRepository {
  /// emits a list of [Collector] pertaining to a company if any
  Stream<List<Collector?>> watchCollectors(String companyId);

  /// emits a [Collector] with the given collectorID
  Stream<Collector?> watchCollector(String collectorID);

  /// Fetches a [Collector] with the given collectorId
  Future<Collector?> getCollector(String collectorId);

  /// adds a [Collector]
  Future<Collector?> createCollector(Collector collector);

  /// updates a [Collector]
  Future<Collector?> updateCollector(Collector collector);

  /// deletes a [Collector]
  Future<bool> deleteCollector(String collectorID);

  /// emits a list of already used collector names for a specified company
  /// this is used in form validation to prevent duplicate collector names for a company
  Stream<List<String?>> watchCompanyUsedCollectorNames(String companyId);

  /// emits list of already used mqtt message names
  /// this is used in form validation to prevent duplicate mqtt message names for collectors
  Stream<List<String?>> watchCollectorUsedMqttMessageNames();
}

@Riverpod(keepAlive: true)
CollectorRepository collectorRepository(Ref ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseCollectorRepository(supabaseClient);
}

@Riverpod(keepAlive: true)
Stream<List<Collector?>> collectorListStream(Ref ref) {
  final collectorRepository = ref.read(collectorRepositoryProvider);
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return Stream.value([]);
  return collectorRepository.watchCollectors(companyId);
}

@Riverpod(keepAlive: true)
Stream<List<String?>> usedCollectorNamesStream(
    Ref ref) {
  final collectorRepository = ref.read(collectorRepositoryProvider);
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return Stream.value([]);
  return collectorRepository.watchCompanyUsedCollectorNames(companyId);
}

/// Watches a single instance of [Collector] as specified by [String]
@Riverpod(keepAlive: true)
Stream<Collector?> collectorStream(Ref ref, String collectorId) {
  final collectorRepository = ref.watch(collectorRepositoryProvider);
  return collectorRepository.watchCollector(collectorId);
}

@Riverpod(keepAlive: true)
Future<Collector?> collectorFuture(Ref ref, String collectorId) {
  final collectorRepository = ref.read(collectorRepositoryProvider);
  return collectorRepository.getCollector(collectorId);
}

@Riverpod(keepAlive: true)
Stream<List<String?>> collectorUsedMqttMessageNamesStream(
    Ref ref) {
  final collectorRepository = ref.read(collectorRepositoryProvider);
  return collectorRepository.watchCollectorUsedMqttMessageNames();
}
