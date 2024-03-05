import 'package:irrigazione_iot/src/features/sectors/domain/sector_status.dart';

List<SectorStatus> _generateSectorStatus() {
  List<SectorStatus> sectorStatusList = [];
  int sectorId = 1;
  int status = 1;

  for (int i = 0; i < 24; i++) {
    DateTime when = DateTime.now().subtract(Duration(minutes: i));
    SectorStatus sectorStatus = SectorStatus(
      sectorId: sectorId.toString(),
      status: status.toString(),
      when: when,
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
