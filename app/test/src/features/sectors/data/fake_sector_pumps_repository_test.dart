import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sector_pumps.dart';
import 'package:irrigazione_iot/src/features/sectors/data/fake_sector_pumps_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pump.dart';

void main() {
  const testSectorId = '1';
  final expectedSectorPumps = kFakeSectorPumps
      .where((sectorPump) => sectorPump.sectorId == testSectorId)
      .toList();
  final sectorPumpToAdd = SectorPump(
    pumpId: '90',
    sectorId: '20',
    id: '90',
    createdAt: DateTime.parse('2022-01-01'),
  );
  FakeSectorPumpRepository makeFakeSectorPumpRepository() =>
      FakeSectorPumpRepository(addDelay: false);

  late FakeSectorPumpRepository repository;

  setUpAll(() {
    repository = makeFakeSectorPumpRepository();
  });

  tearDownAll(() {
    repository.dispose();
  });

  group('FakeSectorPumpRepository', () {
    test('getSectorPumps(testSectorId) returns the expected result', () async {
      await expectLater(repository.getSectorPumps(testSectorId),
          completion(expectedSectorPumps));
    });

    test('getSectorPumps(9000) returns an empty list', () async {
      await expectLater(repository.getSectorPumps('9000'), completion(isEmpty));
    });

    test('watchSectorPumps(testSectorId) emits the expected result', () {
      expect(repository.watchSectorPumps(testSectorId),
          emits(expectedSectorPumps));
    });

    test('watchSectorPumps(9000) emits an empty list', () {
      expect(repository.watchSectorPumps('9000'), emits(isEmpty));
    });

    test('addSectorPump works as expected', () async {
      await expectLater(repository.addSectorPump(sectorPumpToAdd),
          completion(isA<SectorPump>()));
    });

    test('deleteSectorPump with valid data completes with true', () async {
      final sectorPump = expectedSectorPumps.first;
      await expectLater(
          repository.deleteSectorPump(sectorPump.id),
          completion(isTrue));
    });

    test(
        'deleteSectorPump with valid sectorId but invalid sectorPumpId completes with false',
        () async {
      await expectLater(
        repository.deleteSectorPump('901919'),
        completion(isFalse),
      );
    });


  });
}
