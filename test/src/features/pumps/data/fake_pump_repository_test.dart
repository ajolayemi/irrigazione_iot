import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';

void main() {
  FakePumpRepository makePumpRepository() => FakePumpRepository();
  group('testing fake pump repository', () {
    test('filter pump for company with id 1 = success', () {
      final pumpRepository = makePumpRepository();
      expect(pumpRepository.getCompanyPumps('1'), isA<Future<List<Pump>>>());
    });

    test('watch company pumps with id 1 = success', () {
      final pumpRepository = makePumpRepository();
      expect(pumpRepository.watchCompanyPumps('1'), isA<Stream<List<Pump>>>());
    });

    test("filter company with a non-existent id returns an empty list", () {
      final pumpRepository = makePumpRepository();
      expect(pumpRepository.getCompanyPumps('100'), completion(isEmpty));
    });

    test("watch company with a non-existent id returns an empty list", () {
      final pumpRepository = makePumpRepository();
      expect(pumpRepository.watchCompanyPumps('100'), emits(isEmpty));
    });
  });
}
