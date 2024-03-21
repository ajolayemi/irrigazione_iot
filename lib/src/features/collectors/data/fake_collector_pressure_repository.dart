import 'package:irrigazione_iot/src/features/collectors/data/collector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_pressure.dart';

class FakeCollectorPressureRepository implements CollectorPressureRepository {
  @override
  Future<CollectorPressure?> getCollectorPressure({required CollectorID collectorId}) {
    // TODO: implement getCollectorPressure
    throw UnimplementedError();
  }

  @override
  Stream<CollectorPressure?> watchCollectorPressure({required CollectorID collectorId}) {
    // TODO: implement watchCollectorPressure
    throw UnimplementedError();
  }

}