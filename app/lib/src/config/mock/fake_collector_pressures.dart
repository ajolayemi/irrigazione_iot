import 'package:irrigazione_iot/src/config/mock/fake_collectors.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_pressure.dart';

List<CollectorPressure> _generateCollectorPressure() {
  int availableCollectorsLength = kFakeCollectors.length;
  List<CollectorPressure> collectorPressureList = [];
  int collectorId = 1;
  double filterInPressure = 1.3;
  double filterOutPressure = 0.5;

  for (int i = 0; i < availableCollectorsLength * 2; i++) {
    DateTime lastUpdated = DateTime.now().subtract(Duration(minutes: i));
    CollectorPressure collectorPressure = CollectorPressure(
      collectorId: collectorId.toString(),
      filterInPressure: filterInPressure,
      filterOutPressure: filterOutPressure,
      timestamp: lastUpdated,
    );
    collectorPressureList.add(collectorPressure);

    if ((i + 1) % 2 == 0) {
      collectorId++;
    }
    filterInPressure += 0.1;
    filterOutPressure += 0.1;
  }

  return collectorPressureList;
}

final kFakeCollectorPressures = _generateCollectorPressure();
