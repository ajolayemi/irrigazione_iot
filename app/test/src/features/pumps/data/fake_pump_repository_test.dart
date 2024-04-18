import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';

void main() {
  final List<Pump> expectedResults = [
    Pump(
      id: '1',
      name: 'Pompa 1',
      capacityInVolume: 100,
      consumeRateInKw: 10,
      turnOnCommand: '1',
      turnOffCommand: '2',
      companyId: '1',
      createdAt: DateTime(2024, 2, 1),
      updatedAt: DateTime(2024, 2, 1),
      mqttMessageName: 'pump1',
      hasFilter: true,
    ),
    Pump(
      id: '2',
      name: 'Poia alta',
      capacityInVolume: 200,
      consumeRateInKw: 20,
      turnOnCommand: '3',
      turnOffCommand: '4',
      companyId: '1',
      createdAt: DateTime(2024, 2, 1),
      updatedAt: DateTime(2024, 2, 1),
      mqttMessageName: 'pump2',
      hasFilter: false,
    ),
  ];
  FakePumpRepository makePumpRepository() =>
      FakePumpRepository(addDelay: false);
  group('FakePumpRepository', () {


    test('watchCompanyPumps with id 1 = success', () {
      final pumpRepository = makePumpRepository();
      expect(pumpRepository.watchCompanyPumps('1'), isA<Stream<List<Pump?>>>());
      expect(pumpRepository.watchCompanyPumps('1'), emits(expectedResults));
    });


    test("watchCompanyPumps with a non-existent id returns an empty list", () {
      final pumpRepository = makePumpRepository();
      expect(pumpRepository.watchCompanyPumps('100'), emits(isEmpty));
    });



    test('watchPump with a valid pump id emits a valid value', () {
      final pumpRepo = makePumpRepository();
      expect(pumpRepo.watchPump('1'), isA<Stream<Pump?>>());
      expect(pumpRepo.watchPump('1'), emits(expectedResults[0]));
    });

    test('watchPump with an invalid pump id emits null', () {
      final pumpRepo = makePumpRepository();
      expect(pumpRepo.watchPump('1000'), isA<Stream<Pump?>>());
      expect(pumpRepo.watchPump('1000'), emits(isNull));
    });

    test('createPump works as expected', () async {
      // id and companyId aren't provided as that is handled directly
      // by [createPump func]
      final toCreate = Pump(
        id: '',
        name: 'Fake Pump',
        capacityInVolume: 1000,
        consumeRateInKw: 100,
        turnOnCommand: '4',
        turnOffCommand: '5',
        companyId: '',
        createdAt: DateTime.parse('2024-02-01'),
        updatedAt: DateTime.parse('2024-02-01'),
        mqttMessageName: 'fake_pump',
        hasFilter: true,
      );

      final repo = makePumpRepository();
      final createdPump = await repo.createPump(toCreate,);
      final expectedRes =
          toCreate.copyWith(id: createdPump?.id, companyId: '');
      expect(
        createdPump,
        expectedRes,
      );
    });


    test('watchCompanyUsedPumpNames returns valid list', () {
      final repo = makePumpRepository();
      expect(repo.watchCompanyUsedPumpNames(expectedResults[0].companyId),
          emits(isNotEmpty));
    });

    test('watchCompanyUsedPumpNames returns empty list', () {
      final repo = makePumpRepository();
      expect(repo.watchCompanyUsedPumpNames('900'), emits(isEmpty));
    });

    test('watchCompanyUsedPumpOffCommands returns valid list', () {
      final repo = makePumpRepository();
      expect(repo.watchCompanyUsedPumpOffCommands(expectedResults[0].companyId),
          emits(isNotEmpty));
    });

    test('watchCompanyUsedPumpOffCommands returns empty list', () {
      final repo = makePumpRepository();
      expect(repo.watchCompanyUsedPumpOffCommands('900'), emits(isEmpty));
    });

    test('watchCompanyUsedPumpOnCommands returns valid list', () {
      final repo = makePumpRepository();
      expect(repo.watchCompanyUsedPumpOnCommands(expectedResults[0].companyId),
          emits(isNotEmpty));
    });

    test('watchCompanyUsedPumpOnCommands returns empty list', () {
      final repo = makePumpRepository();
      expect(repo.watchCompanyUsedPumpOnCommands('900'), emits(isEmpty));
    });
  });
}
