import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_pump_status.dart';
import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';

void main() {
  final expectedPumpStatus = kFakePumpStatus[0];
  const pumpForInvalidTests = Pump(
      id: 'aaa',
      name: 'Invalid',
      capacityInVolume: 100,
      consumeRateInKw: 10,
      commandForOn: '9',
      commandForOff: '8',
      companyId: 'invalid');
  FakePumpStatusRepository makePumpStatusRepository() =>
      FakePumpStatusRepository(addDelay: false);
  group('FakePumpStatusRepository', () {
    test('getPumpStatus(1) returns a valid pumpStatus', () {
      final pumpStatusRepository = makePumpStatusRepository();
      addTearDown(pumpStatusRepository.dispose);
      expect(pumpStatusRepository.getPumpStatus('1'),
          completion(expectedPumpStatus));
    });

    test('getPumpStatus(9000) returns null', () {
      final pumpStatusRepository = makePumpStatusRepository();
      addTearDown(pumpStatusRepository.dispose);
      expect(pumpStatusRepository.getPumpStatus('9000'), completion(isNull));
    });

    test('watchPumpStatus(1) returns a valid pumpStatus', () {
      final pumpStatusRepository = makePumpStatusRepository();
      addTearDown(pumpStatusRepository.dispose);
      expect(
        pumpStatusRepository.watchPumpStatus('1'),
        emits(expectedPumpStatus),
      );
    });

    test('watchPumpStatus(9000) emits null', () {
      final pumpStatusRepository = makePumpStatusRepository();
      addTearDown(pumpStatusRepository.dispose);
      expect(pumpStatusRepository.watchPumpStatus('9000'), emits(isNull));
    });

    test('togglePumpStatus(1, 2) completes successfully', () async {
      final pumpStatusRepository = makePumpStatusRepository();
      addTearDown(pumpStatusRepository.dispose);
      await pumpStatusRepository.togglePumpStatus('1', '2');
      final statusAfterUpdate = await pumpStatusRepository.getPumpStatus('1');
      final stat = statusAfterUpdate?.status;
      expect(stat, equals('2'));
    });

    test('getLastDispensation returns a valid DateTime', () async {
      final pumpStatusRepository = makePumpStatusRepository();
      addTearDown(pumpStatusRepository.dispose);
      await expectLater(
        pumpStatusRepository.getLastDispensation(kFakePumps.first),
        completion(isA<DateTime>()),
      );
    });

    test('getLastDispensation returns null', () async {
      final pumpStatusRepository = makePumpStatusRepository();
      addTearDown(pumpStatusRepository.dispose);
      await expectLater(
        pumpStatusRepository.getLastDispensation(pumpForInvalidTests),
        completion(isNull),
      );
    });

    test('watchLastDispensation emits a valid DateTime', () {
      final pumpStatusRepository = makePumpStatusRepository();
      addTearDown(pumpStatusRepository.dispose);
      expect(pumpStatusRepository.watchLastDispensation(kFakePumps.first),
          emits(isA<DateTime>()));
    });

    test('watchLastDispensation emits null', () async {
      final pumpStatusRepository = makePumpStatusRepository();
      addTearDown(pumpStatusRepository.dispose);
      expect(
        pumpStatusRepository.watchLastDispensation(pumpForInvalidTests),
        emits(isNull),
      );
    });
  });
}
