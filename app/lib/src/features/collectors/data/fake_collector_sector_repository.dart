import 'package:collection/collection.dart';

import '../../../config/mock/fake_collector_sectors.dart';
import 'collector_sector_repository.dart';
import '../model/collector.dart';
import '../model/collector_sector.dart';
import '../../company_users/model/company.dart';
import '../../../utils/delay.dart';
import '../../../utils/in_memory_store.dart';

class FakeCollectorSectorRepository implements CollectorSectorRepository {
  FakeCollectorSectorRepository({this.addDelay = true});
  final bool addDelay;

  final _collectorSectorsState = InMemoryStore<List<CollectorSector>>(
    kFakeCollectorSectors,
  );

  List<CollectorSector> get value => _collectorSectorsState.value;

  Stream<List<CollectorSector>> get stream => _collectorSectorsState.stream;

  static CollectorSector? _getCollectorSectorById(
      List<CollectorSector> collectorSectors, CollectorID id) {
    return collectorSectors.firstWhereOrNull(
      (collectorSector) => collectorSector.collectorId == id,
    );
  }

  static List<CollectorSector?> _getCollectorSectors(
      List<CollectorSector> collectorSectors, CollectorID collectorId) {
    return collectorSectors
        .where((collectorSector) => collectorSector.collectorId == collectorId)
        .toList();
  }

  static List<CollectorSector?> _getCollectorSectorsByCompanyId(
    List<CollectorSector> collectorSectors,
    CompanyID companyId,
  ) {
    return collectorSectors
        .where((collectorSector) => collectorSector.companyId == companyId)
        .toList();
  }

  void dispose() => _collectorSectorsState.close();

  @override
  Future<CollectorSector?> addCollectorSector(
      {required CollectorSector collectorSector}) async {
    await delay(addDelay);
    final currentCollectorSectors = [...value];
    currentCollectorSectors.add(collectorSector);
    _collectorSectorsState.value = currentCollectorSectors;
    return _getCollectorSectorById(value, collectorSector.collectorId);
  }

  @override
  Future<bool> deleteCollectorSector({
    required CollectorSector collectorSector,
  }) async {
    await delay(addDelay);
    final currentCollectorSectors = [...value];
    final collectorSectorIndex =
        currentCollectorSectors.indexWhere((cs) => cs == collectorSector);
    if (collectorSectorIndex == -1) {
      return false;
    }
    currentCollectorSectors.removeAt(collectorSectorIndex);
    _collectorSectorsState.value = currentCollectorSectors;
    return _getCollectorSectorById(value, collectorSector.collectorId) == null;
  }

  @override
  Future<List<CollectorSector?>> getCollectorSectorsById(
      {required String collectorId}) {
    return Future.value(_getCollectorSectors(value, collectorId));
  }

  @override
  Stream<List<CollectorSector?>> watchCollectorSectorsById(
      {required String collectorId}) {
    return stream.map(
      (collectorSectors) => _getCollectorSectors(collectorSectors, collectorId),
    );
  }

  @override
  Future<List<CollectorSector?>> getCollectorSectorsByCompanyId(
      {required CompanyID companyId}) {
    return Future.value(_getCollectorSectorsByCompanyId(value, companyId));
  }

  @override
  Stream<List<CollectorSector?>> watchCollectorSectorsByCompanyId(
      {required CompanyID companyId}) {
    return stream
      ..map(
        (collectorSector) =>
            _getCollectorSectorsByCompanyId(collectorSector, companyId),
      );
  }
}