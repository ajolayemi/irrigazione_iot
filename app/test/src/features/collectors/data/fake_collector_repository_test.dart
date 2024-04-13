import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_collectors.dart';
import 'package:irrigazione_iot/src/features/collectors/data/fake_collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';

void main() {
  const testCollectorId = '1';
  final expectedCollector = kFakeCollectors[0];
  const testCompanyId = '1';
  final expectedCompanyCollectors = kFakeCollectors
      .where((collector) => collector.companyId == testCompanyId)
      .toList();

  final collectorToAdd = Collector.empty().copyWith(
    name: "testCollector",
    connectedFilterName: "testFilter",
  );

  final expectedCollectorAfterAddition = collectorToAdd.copyWith(
    companyId: testCompanyId,
    id: '27',
  );

  final expectedResultAfterUpdate = expectedCollector.copyWith(
    connectedFilterName: "testFilterUpdated",
  );

  late FakeCollectorRepository fakeCollectorRepository;

  setUpAll(() {
    fakeCollectorRepository = FakeCollectorRepository(addDelay: false);
  });

  tearDownAll(() {
    fakeCollectorRepository.dispose();
  });

  group('FakeCollectorRepository', () {
    test('getCollector(1) returns first item', () async {
      expectLater(fakeCollectorRepository.getCollector(testCollectorId),
          completion(expectedCollector));
    });

    test('getCollector(9000) returns null', () async {
      expectLater(
        fakeCollectorRepository.getCollector('9000'),
        completion(null),
      );
    });

    test('getCollectors(1) returns a list of collectors', () async {
      expectLater(fakeCollectorRepository.getCollectors(testCompanyId),
          completion(expectedCompanyCollectors));
    });

    test('getCollectors(9000) returns an empty list', () async {
      expectLater(
        fakeCollectorRepository.getCollectors('9000'),
        completion(isEmpty),
      );
    });

    test('watchCollector(1) emits expected collector', () {
      expect(
        fakeCollectorRepository.watchCollector(testCollectorId),
        emits(expectedCollector),
      );
    });

    test('watchCollector(9000) emits null', () {
      expect(
        fakeCollectorRepository.watchCollector('9000'),
        emits(null),
      );
    });

    test('watchCollectors(1) emits a list of collectors', () {
      expect(
        fakeCollectorRepository.watchCollectors(testCompanyId),
        emits(expectedCompanyCollectors),
      );
    });

    test('watchCollectors(9000) emits an empty list', () {
      expect(
        fakeCollectorRepository.watchCollectors('9000'),
        emits(isEmpty),
      );
    });

    test('watchCompanyUsedCollectorNames(1) emits a list of collector names',
        () {
      expect(
        fakeCollectorRepository.watchCompanyUsedCollectorNames(testCompanyId),
        emits(expectedCompanyCollectors
            .map((collector) => collector.name.toLowerCase())
            .toList()),
      );
    });

    test('watchCompanyUsedCollectorNames(9000) emits an empty list', () {
      expect(
        fakeCollectorRepository.watchCompanyUsedCollectorNames('9000'),
        emits(isEmpty),
      );
    });

    test('addCollector() adds a collector', () async {
      expectLater(
        fakeCollectorRepository.addCollector(collectorToAdd, testCompanyId),
        completion(expectedCollectorAfterAddition),
      );
    });

    test('updateCollector() updates a collector', () async {
      expectLater(
        fakeCollectorRepository.updateCollector(
          expectedResultAfterUpdate,
          testCompanyId,
        ),
        completion(expectedResultAfterUpdate),
      );
    });

    test('updateCollector() with a non existent collector returns null',
        () async {
      expectLater(
        fakeCollectorRepository.updateCollector(
            expectedCollector.copyWith(id: '9000'), testCompanyId),
        completion(null),
      );
    });

    test('deleteCollector() deletes a collector', () async {
      expectLater(
        fakeCollectorRepository.deleteCollector(testCollectorId),
        completion(true),
      );
    });

    test('deleteCollector() with a non existent collector returns false',
        () async {
      expectLater(
        fakeCollectorRepository.deleteCollector('9000'),
        completion(false),
      );
    });
  });
}
