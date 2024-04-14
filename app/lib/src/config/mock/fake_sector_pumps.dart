import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sectors.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pump.dart';

List<SectorPump> generateSectorPumps() {
  List<SectorPump> sectorPumps = [];

  for (int i = 0; i < kFakeSectors.length; i++) {
    Sector sector = kFakeSectors[i];
    final companyPumps =
        kFakePumps.where((pump) => pump.companyId == sector.companyId).toList();
    if (companyPumps.isEmpty) continue;
    Pump pump = companyPumps[i % companyPumps.length];

    SectorPump sectorPump = SectorPump(
      sectorId: sector.id,
      pumpId: pump.id,
      id: i.toString(),
      createdAt: DateTime.now(),
    );
    sectorPumps.add(sectorPump);
  }

  return sectorPumps;
}

final kFakeSectorPumps = generateSectorPumps();
