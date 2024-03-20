import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/mock/fake_collectors.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeCollectorRepository implements CollectorRepository {
  FakeCollectorRepository({this.addDelay = true});
  final bool addDelay;

  final _collectorState = InMemoryStore<List<Collector>>(kFakeCollectors);

  List<Collector> get value => _collectorState.value;

  Stream<List<Collector>> get stream => _collectorState.stream;

  static Collector? _getCollectorById(
      List<Collector> collectors, CollectorID id) {
    return collectors.firstWhereOrNull(
      (collector) => collector.id == id,
    );
  }

  void dispose() => _collectorState.close();

  @override
  Future<Collector?> addCollector(
      Collector collector, CompanyID companyId) async {
    await delay(addDelay);

    // validation logic will be handled directly in the form
    final lastUsedCollectorId = value
        .map((collector) => int.tryParse(collector.id) ?? 0)
        .reduce((maxId, currentId) => maxId > currentId ? maxId : currentId);
    final finalCollector = collector.copyWith(
      id: '${lastUsedCollectorId + 1}',
      companyId: companyId,
    );

    final currentCollectors = [...value];
    currentCollectors.add(finalCollector);
    _collectorState.value = currentCollectors;
    return Future.value(
      _getCollectorById(value, finalCollector.id),
    );
  }

  @override
  Future<Collector?> updateCollector(
      Collector collector, CompanyID companyId) async {
    await delay(addDelay);
    // validation logic will be handled directly in the form
    final currentCollectors = [...value];
    final index = currentCollectors.indexWhere(
      (c) => c.id == collector.id && c.companyId == companyId,
    );
    if (index < 0) return Future.value(null);
    // return early if the new provided collector is the same as the old one
    if (currentCollectors[index] == collector) return Future.value(collector);
    currentCollectors[index] = collector;
    _collectorState.value = currentCollectors;
    return Future.value(
      _getCollectorById(value, collector.id),
    );
  }

  @override
  Future<bool> deleteCollector(CollectorID collectorID) async {
    await delay(addDelay);
    final currentCollectors = [...value];
    final index = currentCollectors.indexWhere((c) => c.id == collectorID);
    if (index < 0) return Future.value(false);
    currentCollectors.removeAt(index);
    _collectorState.value = currentCollectors;
    return Future.value(
      _getCollectorById(value, collectorID) == null,
    );
  }

  @override
  Future<Collector?> getCollector(CollectorID collectorID) async {
    await delay(addDelay);
    return Future.value(_getCollectorById(value, collectorID));
  }

  @override
  Future<List<Collector?>> getCollectors(CompanyID companyId) async {
    await delay(addDelay);
    return Future.value(
      value.where((c) => c.companyId == companyId).toList(),
    );
  }

  @override
  Stream<Collector?> watchCollector(CollectorID collectorID) {
    return stream.map(
      (collectors) => _getCollectorById(collectors, collectorID),
    );
  }

  @override
  Stream<List<Collector?>> watchCollectors(CompanyID companyId) {
    return stream.map((collectors) => collectors
        .where(
          (c) => c.companyId == companyId,
        )
        .toList());
  }

  @override
  Stream<List<String?>> watchCompanyUsedCollectorNames(CompanyID companyId) {
    return stream.map(
      (collectors) => collectors
          .where(
            (c) => c.companyId == companyId,
          )
          .map((collector) => collector.name.toLowerCase())
          .toList(),
    );
  }

// todo change how this is implemented
  @override
  Stream<double?> watchCollectorBatteryLevel(CollectorID collectorID) {
    return Stream.periodic(const Duration(seconds: 40), (_) {
    // Simulate battery level changes
    return (5.0 - 3.0) * (0.5 - 0.5 * (DateTime.now().second % 60) / 30).clamp(0.0, 1.0);
  });
  }
}
