import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sectors.dart';
import 'package:irrigazione_iot/src/features/sectors/data/fake_sector_status_repository.dart';

void main() {
  final invalidSector = kFakeSectors[0].copyWith(
      id: '80000',
      name: 'invalid sector',
      turnOffCommand: '900',
      turnOnCommand: '3800');
  final sectorsForTesting = [kFakeSectors[0], kFakeSectors[1]];

  FakeSectorStatusRepository makeFakeSectorStatusRepository() {
    return FakeSectorStatusRepository(
      addDelay: false,
    );
  }

  group('FakePumpStatusRepository', () {
    test('getSectorLastIrrigation works with initial data', () async {
      final repo = makeFakeSectorStatusRepository();
      addTearDown(repo.dispose);
      await expectLater(
          repo.getSectorLastIrrigation(sectorsForTesting.first), isNotNull);
    });

    test('getSectorLastIrrigation returns null with invalid sector id',
        () async {
      final repo = makeFakeSectorStatusRepository();
      addTearDown(repo.dispose);
      await expectLater(
          repo.getSectorLastIrrigation(invalidSector), completion(isNull));
    });

    test('getSectorStatus works with initial data', () async {
      final repo = makeFakeSectorStatusRepository();
      addTearDown(repo.dispose);
      await expectLater(repo.getSectorStatus(sectorsForTesting.first.id),
          completion(isNotNull));
    });

    test('getSectorStatus returns null with invalid sector id', () async {
      final repo = makeFakeSectorStatusRepository();
      addTearDown(repo.dispose);
      await expectLater(
          repo.getSectorStatus(invalidSector.id), completion(isNull));
    });

    test(
        "toggleSectorStatus doesn't work with valid sector and invalid status command",
        () async {
      final repo = makeFakeSectorStatusRepository();
      final idForTesting = sectorsForTesting.first.id;
      addTearDown(repo.dispose);
      final statusBeforeToggling = await repo.getSectorStatus(idForTesting);
      await repo.toggleSectorStatus(
        sectorsForTesting.first,
        '70',
      );
      expect(repo.getSectorStatus(sectorsForTesting.first.id),
          completion(statusBeforeToggling));
    });


    test('toggleSectorStatus works with valid sector and valid status command',
        () async {
      final repo = makeFakeSectorStatusRepository();
      final idForTesting = sectorsForTesting.first.id;
      addTearDown(repo.dispose);
      final statusBeforeToggling = await repo.getSectorStatus(idForTesting);
      await repo.toggleSectorStatus(
        sectorsForTesting.first,
        sectorsForTesting.first.turnOffCommand,
      );
      expect(repo.getSectorStatus(sectorsForTesting.first.id),
          completion(isNot(statusBeforeToggling)));
    });

    test('watchSectorLastIrrigation emits valid value', () {
      final repo = makeFakeSectorStatusRepository();
      addTearDown(repo.dispose);
      expect(repo.watchSectorLastIrrigation(sectorsForTesting.first),
          emits(isNotNull));
    });

    test('watchSectorLastIrrigation emits null', () {
      final repo = makeFakeSectorStatusRepository();
      addTearDown(repo.dispose);
      expect(repo.watchSectorLastIrrigation(invalidSector), emits(isNull));
    });

    test('watchSectorStatus emits valid value', () {
      final repo = makeFakeSectorStatusRepository();
      addTearDown(repo.dispose);
      expect(
        repo.watchSectorStatus(sectorsForTesting.first.id),
        emits(isNotNull),
      );
    });

    test('watchSectorStatus emits null', () {
      final repo = makeFakeSectorStatusRepository();
      addTearDown(repo.dispose);
      expect(repo.watchSectorStatus(invalidSector.id), emits(isNull));
    });

    test('getSectorStatus after dispose throws exception', () async {
      final repo = makeFakeSectorStatusRepository();
      repo.dispose();
      expect(repo.toggleSectorStatus(invalidSector, '900'), throwsStateError);
    });
  });
}
