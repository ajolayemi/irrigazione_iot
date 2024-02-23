import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_pump_status.dart';
import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_status_repository.dart';

void main() {
  final expectedPumpStatus = kFakePumpStatus[0];
  FakePumpStatusRepository makePumpStatusRepository() =>
      FakePumpStatusRepository();
  group('testing fake pump status ', () {
    test('getPumpStatus(1) returns a valid pumpStatus', () {
      final pumpStatusRepository = makePumpStatusRepository();
      expect(pumpStatusRepository.getPumpStatus('1'),
          completion(expectedPumpStatus));
    });

    test('watchPumpStatus(1) returns a valid pumpStatus', () {
      final pumpStatusRepository = makePumpStatusRepository();
      expect(
          pumpStatusRepository.watchPumpStatus('1'), emits(expectedPumpStatus));
    });

    test('togglePumpStatus(1, 1) completes successfully', () {
      final pumpStatusRepository = makePumpStatusRepository();
      expect(pumpStatusRepository.togglePumpStatus('1', '1'), completes);
    });
  });
}
