import 'package:irrigazione_iot/src/features/pumps/model/pump_status.dart';

List<PumpStatus> _generatePumpStatus() {
  List<PumpStatus> pumpStatusList = [];
  int pumpId = 1;
  int status = 1;

  for (int i = 0; i < 24; i++) {
    DateTime lastUpdated = DateTime.now().subtract(Duration(minutes: i));
    PumpStatus pumpStatus = PumpStatus(
      pumpId: pumpId.toString(),
      status: status.toString(),
      lastUpdated: lastUpdated,
    );
    pumpStatusList.add(pumpStatus);

    if ((i + 1) % 2 == 0) {
      pumpId++;
    }
    status++;
  }

  return pumpStatusList;
}

final kFakePumpStatus = _generatePumpStatus();
