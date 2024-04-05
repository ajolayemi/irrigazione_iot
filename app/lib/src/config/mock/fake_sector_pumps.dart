import 'fake_pumps.dart';
import 'fake_sectors.dart';
import '../../features/pumps/model/pump.dart';
import '../../features/sectors/model/sector.dart';
import '../../features/sectors/model/sector_pump.dart';

List<SectorPump> generateSectorPumps() {
  List<SectorPump> sectorPumps = [];

  for (int i = 0; i < kFakeSectors.length; i++) {
    Sector sector = kFakeSectors[i];
    final companyPumps =
        kFakePumps.where((pump) => pump.companyId == sector.companyId).toList();
    if (companyPumps.isEmpty) continue;
    Pump pump = companyPumps[i % companyPumps.length];

    SectorPump sectorPump = SectorPump(sectorId: sector.id, pumpId: pump.id);
    sectorPumps.add(sectorPump);
  }

  return sectorPumps;
}

final kFakeSectorPumps = generateSectorPumps();
