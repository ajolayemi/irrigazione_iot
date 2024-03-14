import 'dart:math';

import 'package:irrigazione_iot/src/config/mock/fake_collectors.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sectors.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_sector.dart';

final kFakeCollectorSectors = kFakeSectors.expand((sector) {
  final companyId = sector.companyId;
  final companyCollectors = kFakeCollectors
      .where((collector) => collector.companyId == companyId)
      .toList();

  final random = Random();
  final sectorCount = random.nextInt(3) + 2;

  final randomSectors = List<CollectorSector>.generate(sectorCount, (index) {
    final randomSector = kFakeSectors[random.nextInt(kFakeSectors.length)];
    return CollectorSector(
      collectorId: companyCollectors[index].id,
      sectorId: randomSector.id,
    );
  });

  return randomSectors;
}).toList();
