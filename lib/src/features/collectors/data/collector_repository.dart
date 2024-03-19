import 'dart:async';

import 'package:irrigazione_iot/src/features/collectors/data/fake_collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'collector_repository.g.dart';

abstract class CollectorRepository {
  /// returns a list of [Collector] pertaining to a company if any
  Future<List<Collector?>> getCollectors(CompanyID companyId);

  /// emits a list of [Collector] pertaining to a company if any
  Stream<List<Collector?>> watchCollectors(CompanyID companyId);

  /// emits a [Collector] with the given collectorID
  Stream<Collector?> watchCollector(CollectorID collectorID);

  /// returns a [Collector] with the given collectorID
  Future<Collector?> getCollector(CollectorID collectorID);

  /// adds a [Collector]
  Future<Collector?> addCollector(Collector collector, CompanyID companyId);

  /// updates a [Collector]
  Future<Collector?> updateCollector(Collector collector, CompanyID companyId);

  /// deletes a [Collector]
  Future<bool> deleteCollector(CollectorID collectorID);

  /// emits a list of already used collector names for a specified company
  /// this is used in form validation to prevent duplicate collector names for a company
  Stream<List<String?>> watchCompanyUsedCollectorNames(CompanyID companyId);
}

@Riverpod(keepAlive: true)
CollectorRepository collectorRepository(CollectorRepositoryRef ref) {
  // todo return remote repository as default
  return FakeCollectorRepository();
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

/// Watches a single instance of [Collector] as specified by [CollectorID]
@riverpod
Stream<Collector?> collectorStream(
    CollectorStreamRef ref, CollectorID collectorId) {
  final collectorRepository = ref.watch(collectorRepositoryProvider);
  return collectorRepository.watchCollector(collectorId);
}

/// Gets a single instance of [Collector] as specified by [CollectorID]
@riverpod
Future<Collector?> collectorFuture(
    CollectorFutureRef ref, CollectorID collectorId) {
  final collectorRepository = ref.watch(collectorRepositoryProvider);
  return collectorRepository.getCollector(collectorId);
}
