import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_collector_sectors.dart';
import 'package:irrigazione_iot/src/features/collectors/data/fake_collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_sector.dart';

void main() {
  const testCollectorId = '1';
  final expectedCollectorSectors = kFakeCollectorSectors
      .where(
        (collectorSector) => collectorSector.collectorId == testCollectorId,
      )
      .toList();

  final collectorToDelete = expectedCollectorSectors.isNotEmpty
      ? expectedCollectorSectors.first
      : const CollectorSector.empty();

  late FakeCollectorSectorRepository fakeCollectorSectorRepository;

  setUpAll(() {
    fakeCollectorSectorRepository =
        FakeCollectorSectorRepository(addDelay: false);
  });

  tearDownAll(
    () => {
      fakeCollectorSectorRepository.dispose(),
    },
  );

  group('FakeCollectorSectorRepository', () {
    test('getCollectorSectors(1) should return the expected value', () async {
      expectLater(
        fakeCollectorSectorRepository.getCollectorSectorsById(testCollectorId),
        completion(expectedCollectorSectors),
      );
    });

    test('getCollectorSectors(9000) should return an empty list', () async {
      expectLater(
        fakeCollectorSectorRepository.getCollectorSectorsById('9000'),
        completion(isEmpty),
      );
    });

    test('watchCollectorSectors(1) should emit the expected value', () {
      expect(
          fakeCollectorSectorRepository.watchCollectorSectorsById(
            testCollectorId,
          ),
          emits(expectedCollectorSectors));
    });

    test('watchCollectorSectors(9000) should emit an empty list', () {
      expect(fakeCollectorSectorRepository.watchCollectorSectorsById('9000'),
          emits(isEmpty));
    });

    test('addCollectorSector() adds a new collector sector', () async {
      final toAdd = CollectorSector(
          id: '9000',
          collectorId: '9000',
          sectorId: '9000',
          createdAt: DateTime.parse('2024-01-01'));

      expectLater(
        fakeCollectorSectorRepository.createCollectorSector(toAdd),
        completion(toAdd),
      );
    });

    test('deleteCollectorSector() with valid parameters returns true',
        () async {
      expectLater(
          fakeCollectorSectorRepository
              .deleteCollectorSector(collectorToDelete),
          completion(isTrue));
    });

    test('deleteCollectorSector() with invalid parameters returns false',
        () async {
      expectLater(
          fakeCollectorSectorRepository
              .deleteCollectorSector(const CollectorSector.empty()),
          completion(isFalse));
    });
  });
}
