import 'dart:math';

import 'fake_collectors.dart';
import 'fake_sectors.dart';
import '../../features/collectors/model/collector_sector.dart';

List<CollectorSector> generateFakeCollectorSectors() {
  final collectorSectors = <CollectorSector>[];
  final random = Random();
  for (final collector in kFakeCollectors) {
    final sectors = kFakeSectors
        .where((sector) => sector.companyId == collector.companyId)
        .toList();
    final sector = sectors[random.nextInt(sectors.length)];
    collectorSectors.add(CollectorSector(
      collectorId: collector.id,
      sectorId: sector.id,
      companyId: sector.companyId,
    ));
  }
  return collectorSectors;
}

final kFakeCollectorSectors = generateFakeCollectorSectors();
