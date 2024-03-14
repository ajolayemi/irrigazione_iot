import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/mock/fake_collector_sectors.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_sector.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

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

  void dispose() => _collectorSectorsState.close();

  @override
  Future<CollectorSector?> addCollectorSector(
      CollectorSector collectorSector) async {
    await delay(addDelay);
    final currentCollectorSectors = [...value];
    currentCollectorSectors.add(collectorSector);
    _collectorSectorsState.value = currentCollectorSectors;
    return _getCollectorSectorById(value, collectorSector.collectorId);
  }

  @override
  Future<bool> deleteCollectorSector(
      String collectorId, String sectorId) async {
    await delay(addDelay);
    final currentCollectorSectors = [...value];
    final collectorSectorIndex = currentCollectorSectors.indexWhere(
      (collectorSector) =>
          collectorSector.collectorId == collectorId &&
          collectorSector.sectorId == sectorId,
    );
    if (collectorSectorIndex == -1) {
      return false;
    }
    currentCollectorSectors.removeAt(collectorSectorIndex);
    _collectorSectorsState.value = currentCollectorSectors;
    return _getCollectorSectorById(value, collectorId) == null;
  }

  @override
  Future<List<CollectorSector?>> getCollectorSectors(String collectorId) {
    return Future.value(_getCollectorSectors(value, collectorId));
  }

  @override
  Stream<List<CollectorSector?>> watchCollectorSectors(String collectorId) {
    return stream.map(
      (collectorSectors) => _getCollectorSectors(collectorSectors, collectorId),
    );
  }
}
