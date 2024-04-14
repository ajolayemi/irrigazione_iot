import 'dart:math';

import 'package:irrigazione_iot/src/config/mock/fake_collectors.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sectors.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_sector.dart';

List<CollectorSector> generateFakeCollectorSectors() {
  int id = 0;
  final collectorSectors = <CollectorSector>[];
  final random = Random();
  for (final collector in kFakeCollectors) {
    final sectors = kFakeSectors
        .where((sector) => sector.companyId == collector.companyId)
        .toList();
    final sector = sectors[random.nextInt(sectors.length)];
    collectorSectors.add(CollectorSector(
      id: (id++).toString(),
      collectorId: collector.id,
      sectorId: sector.id,
      createdAt: DateTime.now(),
    ));
  }
  return collectorSectors;
}

final kFakeCollectorSectors = generateFakeCollectorSectors();
