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
          completion(sectorPumpToAdd));
    });

    test('deleteSectorPump with valid data completes with true', () async {
      final sectorPump = expectedSectorPumps.first;
      await expectLater(
          repository.deleteSectorPump(sectorPump.sectorId, sectorPump.pumpId),
          completion(isTrue));
    });

    test(
        'deleteSectorPump with valid sectorId but invalid pumpId completes with false ',
        () async {
      final sectorPump = expectedSectorPumps.first;
      await expectLater(
        repository.deleteSectorPump(sectorPump.sectorId, '980'),
        completion(isFalse),
      );
    });

    test(
        'deleteSectorPump with invalid sectorId but valid pumpId completes with false ',
        () async {
      final sectorPump = expectedSectorPumps.first;
      await expectLater(
        repository.deleteSectorPump('10000', sectorPump.pumpId),
        completion(isFalse),
      );
    });

    test(
        'deleteSectorPump with invalid sectorId and pumpId completes with false ',
        () async {
      await expectLater(
        repository.deleteSectorPump('9000', '6000'),
        completion(isFalse),
      );
    });
  });
}
