import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_pump_status.dart';
import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';

void main() {
  final testPump = kFakePumps[0];
  final expectedPumpStatus = kFakePumpStatus[0].statusBoolean;

  FakePumpStatusRepository makePumpStatusRepository() =>
      FakePumpStatusRepository(addDelay: false);
  group('FakePumpStatusRepository', () {
    test('watchPumpStatus(1) returns a valid pumpStatus', () {
      final pumpStatusRepository = makePumpStatusRepository();
      addTearDown(pumpStatusRepository.dispose);
      expect(
        pumpStatusRepository.watchPumpStatus(testPump.id),
        emits(expectedPumpStatus),
      );
    });

    test('watchPumpStatus(9000) emits null', () {
      final pumpStatusRepository = makePumpStatusRepository();
      addTearDown(pumpStatusRepository.dispose);
      expect(pumpStatusRepository.watchPumpStatus(const Pump.empty().id),
          emits(isNull));
    });
  });
}
