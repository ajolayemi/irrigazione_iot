import 'package:irrigazione_iot/src/config/mock/fake_sectors.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_status.dart';

List<SectorStatus> _generateSectorStatus() {
  List<SectorStatus> sectorStatusList = [];
  int sectorId = 1;
  int status = 1;

  for (int i = 0; i < 24; i++) {
    final sector = kFakeSectors.firstWhere((element) => element.id == sectorId.toString());
    DateTime when = DateTime.now().subtract(Duration(minutes: i));
    SectorStatus sectorStatus = SectorStatus(
      id: i.toString(),
      statusBoolean: sector.turnOnCommand == status.toString(),
      sectorId: sectorId.toString(),
      status: status.toString(),
      createdAt: when,
    );
    sectorStatusList.add(sectorStatus);

    if ((i + 1) % 2 == 0) {
      sectorId++;
    }
    status++;
  }

  return sectorStatusList;
}

final kFakeSectorStatus = _generateSectorStatus();
