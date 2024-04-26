import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_status.dart';

List<PumpStatus> _generatePumpStatus() {
  List<PumpStatus> pumpStatusList = [];
  int pumpId = 1;
  int status = 1;

  for (int i = 0; i < 24; i++) {
    final pump =
        kFakePumps.firstWhere((element) => element.id == pumpId.toString());
    DateTime lastUpdated = DateTime.now().subtract(Duration(minutes: i));
    PumpStatus pumpStatus = PumpStatus(
      id: i.toString(),
      statusBoolean: pump.turnOnCommand == status.toString(),
      pumpId: pumpId.toString(),
      status: status.toString(),
      createdAt: lastUpdated,
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
