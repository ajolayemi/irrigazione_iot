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

  group('FakeSectorStatusRepository', () {
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
      expect(
          repo.toggleSectorStatus(
              sectorId: '900', statusBoolean: true, statusString: '1'),
          throwsStateError);
    });
  });
}
