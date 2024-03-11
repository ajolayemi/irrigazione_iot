import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/enums/irrigation_enums.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sectors.dart';
import 'package:irrigazione_iot/src/features/sectors/data/fake_sectors_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';

void main() {
  const testCompanyId = '1';
  const testSectorId = '1';
  final expectedSector = kFakeSectors
      .where(
        (sector) => sector.id == testSectorId,
      )
      .toList()
      .first;
  final expectedCompanySectors = kFakeSectors
      .where((sector) => sector.companyId == testCompanyId)
      .toList();

  final sectorToUpdate = expectedCompanySectors.firstOrNull;

  const sectorToAdd = Sector(
      id: '200',
      companyId: '4',
      name: 'Sector for test',
      availableSpecie: 'arancia',
      specieVariety: 'sanguinello',
      area: 9000,
      numOfPlants: 20,
      waterConsumptionPerHourByPlant: 20,
      irrigationSystemType: IrrigationSystemType.drip,
      irrigationSource: IrrigationSource.canal,
      turnOnCommand: '80',
      turnOffCommand: '81');

  FakeSectorsRepository makeFakeSectorsRepository() {
    return FakeSectorsRepository(addDelay: false);
  }

  late FakeSectorsRepository repo;

  setUpAll(() {
    repo = makeFakeSectorsRepository();
  });

  tearDownAll(() {
    repo.dispose();
  });

  group('FakeSectorRepository', () {
    test('getSectors(testCompanyId) works as expected', () async {
      await expectLater(
        repo.getSectors(testCompanyId),
        completion(expectedCompanySectors),
      );
    });

    test('getSectors with invalid company id returns an empty list', () async {
      await expectLater(repo.getSectors('9000'), completion(isEmpty));
    });

    test('watchSectors(testCompanyId) works as expected', () async {
      expect(repo.watchSectors(testCompanyId), emits(expectedCompanySectors));
    });

    test('watchSectors with invalid company id emits an empty list', () async {
      expect(repo.watchSectors('9000'), emits(isEmpty));
    });

    test('getSector(testSectorId) returns the expected sector', () async {
      await expectLater(
        repo.getSector(testSectorId),
        completion(expectedSector),
      );
    });

    test('getSector with invalid sector id returns null', () async {
      await expectLater(
        repo.getSector('8900'),
        completion(isNull),
      );
    });

    test('watchSector(testSectorId) emits the expected sector', () {
      expect(repo.watchSector(testSectorId), emits(expectedSector));
    });

    test('watchSector with invalid sector id emits null', () {
      expect(repo.watchSector('90000'), emits(isNull));
    });

    test('watchCompanyUsedSectorNames(testCompanyId) emits a non empty list',
        () {
      expect(
          repo.watchCompanyUsedSectorNames(testCompanyId), emits(isNotEmpty));
    });

    test(
        'watchCompanyUsedSectorNames with invalid companyId emits an empty list',
        () {
      expect(repo.watchCompanyUsedSectorNames('90000'), emits(isEmpty));
    });

    test(
        'watchCompanyUsedSectorOnCommands(testCompanyId) emits a non empty list',
        () {
      expect(repo.watchCompanyUsedSectorOnCommands(testCompanyId),
          emits(isNotEmpty));
    });

    test(
        'watchCompanyUsedSectorOnCommands with invalid companyId emits an empty list',
        () {
      expect(repo.watchCompanyUsedSectorOnCommands('90000'), emits(isEmpty));
    });

    test(
        'watchCompanyUsedSectorOffCommands(testCompanyId) emits a non empty list',
        () {
      expect(repo.watchCompanyUsedSectorOffCommands(testCompanyId),
          emits(isNotEmpty));
    });

    test(
        'watchCompanyUsedSectorOffCommands with invalid companyId emits an empty list',
        () {
      expect(repo.watchCompanyUsedSectorOffCommands('90000'), emits(isEmpty));
    });

    test('addSector works as expected', () async {
      await expectLater(
        repo.addSector(sectorToAdd, sectorToAdd.companyId),
        completion(sectorToAdd),
      );
    });

    test('updateSector with new and valid values works as expected', () async {
      final updatedSector = sectorToUpdate?.copyWith(
        availableSpecie: 'banana',
        specieVariety: 'banana',
      );
      expect(updatedSector, isNotNull);
      final currentValue = await repo.getSector(updatedSector!.id);
      expect(currentValue, sectorToUpdate);

      // update
      await expectLater(
        repo.updateSector(updatedSector, updatedSector.companyId),
        completion(
          isNot(sectorToUpdate),
        ),
      );
    });

    test('updateSector with new values and invalid sectorId returns null',
        () async {
      final updatedSector = sectorToUpdate?.copyWith(
        availableSpecie: 'banana',
        specieVariety: 'banana',
        id: '90000',
      );
      expect(updatedSector, isNotNull);
      final currentValue = await repo.getSector(updatedSector!.id);
      expect(currentValue, isNull);

      // update
      await expectLater(
        repo.updateSector(updatedSector, updatedSector.companyId),
        completion(isNull),
      );
    });

    test('updateSector with new values and invalid companyId returns null',
        () async {
      final updatedSector = sectorToUpdate?.copyWith(
        availableSpecie: 'banana',
        specieVariety: 'banana',
        companyId: '1800',
      );
      expect(updatedSector, isNotNull);

      // update
      await expectLater(
          repo.updateSector(updatedSector!, updatedSector.companyId),
          completion(isNull));
    });

    test('deleteSector(testSectorId) deletes sector as expected', () async {
      await expectLater(repo.deleteSector(testSectorId), completion(isTrue));
    });

    test('deleteSector with invalid sector id does not delete sector as expected', () async {
      await expectLater(repo.deleteSector('8900'), completion(isFalse));
    });
  });
}
