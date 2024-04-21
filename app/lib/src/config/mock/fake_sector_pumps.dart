import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sectors.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pump.dart';

List<SectorPump> generateSectorPumps() {
  List<SectorPump> sectorPumps = [];

  for (int i = 0; i < kFakeSectors.length; i++) {
    final sector = kFakeSectors[i];
    if (i >= kFakePumps.length) break;
    final pump = kFakePumps[i];

    sectorPumps.add(SectorPump(
      id: '${i + 1}',
      sectorId: sector.id,
      pumpId: pump.id,
      createdAt: DateTime.parse('2024-01-01'),
    ));
  }

  return sectorPumps;
}

final kFakeSectorPumps = generateSectorPumps();
