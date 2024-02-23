import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';

void main() {
  final List<Pump> expectedResults = [
    const Pump(
      id: '1',
      name: 'Pompa 1',
      capacityInVolume: 100,
      consumeRateInKw: 10,
      commandForOn: '1',
      commandForOff: '2',
      companyId: '1',
    ),
    const Pump(
      id: '2',
      name: 'Poia alta',
      capacityInVolume: 200,
      consumeRateInKw: 20,
      commandForOn: '3',
      commandForOff: '4',
      companyId: '1',
    ),
  ];
  FakePumpRepository makePumpRepository() => FakePumpRepository();
  group('testing fake pump repository', () {
    test('filter pump for company with id 1 = success', () {
      final pumpRepository = makePumpRepository();
      expect(pumpRepository.getCompanyPumps('1'), isA<Future<List<Pump>>>());
      expect(pumpRepository.getCompanyPumps('1'), completion(expectedResults));

    });

    test('watch company pumps with id 1 = success', () {
      final pumpRepository = makePumpRepository();
      expect(pumpRepository.watchCompanyPumps('1'), isA<Stream<List<Pump>>>());
      expect(pumpRepository.watchCompanyPumps('1'), emits(expectedResults));
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
