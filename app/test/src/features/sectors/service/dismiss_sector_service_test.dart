import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pump.dart';
import 'package:irrigazione_iot/src/features/sectors/service/dismiss_sector_service.dart';

import '../../../mocks.dart';

void main() {
  const testSectorId = '1';

  final sectorRepository = MockSectorRepository();
  final sectorPumpRepository = MockSectorPumpRepository();

  late DismissSectorService dismissSectorService;

  ProviderContainer makeContainer() {
    return ProviderContainer(overrides: [
      sectorsRepositoryProvider.overrideWithValue(sectorRepository),
      sectorPumpRepositoryProvider.overrideWithValue(sectorPumpRepository),
    ]);
  }

  setUpAll(() {
    final container = makeContainer();
    addTearDown(container.dispose);
    dismissSectorService = container.read(dismissSectorServiceProvider);
    registerFallbackValue(
      const Sector.empty(),
    );
    registerFallbackValue(
      const SectorPump(pumpId: '9', sectorId: '9'),
    );
  });

  group('DismissSectorService', () {
    test("dismissSector(1) deletes sector and not it's pumps", () async {
      // setup
      when(() => sectorRepository.deleteSector(testSectorId)).thenAnswer(
        (_) => Future.value(true),
      );

      when(() => sectorPumpRepository.getSectorPumps(testSectorId))
          .thenAnswer((_) => Future.value([]));

      // run
      await dismissSectorService.dismissSector(testSectorId);

      // verify
      verify(() => sectorRepository.deleteSector(testSectorId)).called(1);
      verify(() => sectorPumpRepository.getSectorPumps(testSectorId)).called(1);
      verifyNever(() => sectorPumpRepository.deleteSectorPump(any(), any()));
    });

    test("dismissSector(1) deletes sector and it's pumps", () async {
      // Sector pumps to return
      const sectorPumps = [
        SectorPump(pumpId: '9', sectorId: testSectorId),
        SectorPump(pumpId: '10', sectorId: testSectorId)
      ];
      // setup
      when(() => sectorRepository.deleteSector(testSectorId)).thenAnswer(
        (_) => Future.value(true),
      );

      when(() => sectorPumpRepository.getSectorPumps(testSectorId))
          .thenAnswer((_) => Future.value(sectorPumps));
      when(() => sectorPumpRepository.deleteSectorPump(any(), any()))
          .thenAnswer(
        (_) => Future.value(true),
      );

      // run
      await dismissSectorService.dismissSector(testSectorId);

      // verify
      verify(() => sectorRepository.deleteSector(testSectorId)).called(1);
      verify(() => sectorPumpRepository.getSectorPumps(testSectorId)).called(1);
      verify(() => sectorPumpRepository.deleteSectorPump(
          sectorPumps.first.sectorId, sectorPumps.first.pumpId)).called(1);
      verify(() => sectorPumpRepository.deleteSectorPump(
          sectorPumps.last.sectorId, sectorPumps.last.pumpId)).called(1);
    });
  });
}
