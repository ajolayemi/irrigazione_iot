import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/mock/fake_collector_pressures.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_pressure.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeCollectorPressureRepository implements CollectorPressureRepository {
  FakeCollectorPressureRepository({this.addDelay = false});
  final bool addDelay;

  final _collectorPressureState = InMemoryStore<List<CollectorPressure>>(
    kFakeCollectorPressures,
  );

  static CollectorPressure? _getCollectorPressureById({
    required List<CollectorPressure> collectorPressures,
    required CollectorID id,
  }) {
    return collectorPressures.firstWhereOrNull(
      (collectorPressure) => collectorPressure.collectorId == id,
    );
  }

  @override
  Future<CollectorPressure?> getCollectorPressure(
      {required CollectorID collectorId}) async {
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
      {required CollectorID collectorId}) {
    return _collectorPressureState.stream.map(
      (collectorPressures) => _getCollectorPressureById(
        collectorPressures: collectorPressures,
        id: collectorId,
      ),
    );
  }

  void dispose() => _collectorPressureState.close();
}
