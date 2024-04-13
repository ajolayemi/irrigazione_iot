import 'package:collection/collection.dart';
import '../../../config/mock/fake_collector_pressures.dart';
import 'collector_pressure_repository.dart';
import '../model/collector_pressure.dart';
import '../../../utils/delay.dart';
import '../../../utils/in_memory_store.dart';

class FakeCollectorPressureRepository implements CollectorPressureRepository {
  FakeCollectorPressureRepository({this.addDelay = false});
  final bool addDelay;

  final _collectorPressureState = InMemoryStore<List<CollectorPressure>>(
    kFakeCollectorPressures,
  );

  static CollectorPressure? _getCollectorPressureById({
    required List<CollectorPressure> collectorPressures,
    required String id,
  }) {
    return collectorPressures.firstWhereOrNull(
      (collectorPressure) => collectorPressure.collectorId == id,
    );
  }

  @override
  Future<CollectorPressure?> getCollectorPressure(
      {required String collectorId}) async {
    await delay(addDelay);
    return Future.value(
      _getCollectorPressureById(
        collectorPressures: _collectorPressureState.value,
        id: collectorId,
      ),
    );
  }

  @override
  Stream<CollectorPressure?> watchCollectorPressure(
      {required String collectorId}) {
    return _collectorPressureState.stream.map(
      (collectorPressures) => _getCollectorPressureById(
        collectorPressures: collectorPressures,
        id: collectorId,
      ),
    );
  }

  void dispose() => _collectorPressureState.close();
}
