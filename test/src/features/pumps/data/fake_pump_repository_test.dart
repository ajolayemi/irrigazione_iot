import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';

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
  FakePumpRepository makePumpRepository() =>
      FakePumpRepository(addDelay: false);
  group('FakePumpRepository', () {
    test('getCompanyPumps for company with id 1 = success', () {
      final pumpRepository = makePumpRepository();
      expect(pumpRepository.getCompanyPumps('1'), isA<Future<List<Pump?>>>());
      expect(pumpRepository.getCompanyPumps('1'), completion(expectedResults));
    });

    test('watchCompanyPumps with id 1 = success', () {
      final pumpRepository = makePumpRepository();
      expect(pumpRepository.watchCompanyPumps('1'), isA<Stream<List<Pump?>>>());
      expect(pumpRepository.watchCompanyPumps('1'), emits(expectedResults));
    });

    test("getCompanyPumps with a non-existent id returns an empty list", () {
      final pumpRepository = makePumpRepository();
      expect(pumpRepository.getCompanyPumps('100'), completion(isEmpty));
    });

    test("watchCompanyPumps with a non-existent id returns an empty list", () {
      final pumpRepository = makePumpRepository();
      expect(pumpRepository.watchCompanyPumps('100'), emits(isEmpty));
    });

    test('getPump with an invalid pump id returns valid value', () async {
      final pumpRepo = makePumpRepository();
      expect(pumpRepo.getPump('1'), isA<Future<Pump?>>());
      final res = await pumpRepo.getPump('1');
      expect(res, expectedResults[0]);
    });

    test('getPump with a valid pump id returns null', () async {
      final pumpRepo = makePumpRepository();
      expect(pumpRepo.getPump('1000'), isA<Future<Pump?>>());
      final res = await pumpRepo.getPump('1000');
      expect(res, isNull);
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
      const toCreate = Pump(
          id: '',
          name: 'Fake Pump',
          capacityInVolume: 1000,
          consumeRateInKw: 100,
          commandForOn: '4',
          commandForOff: '5',
          companyId: '');

      final repo = makePumpRepository();
      final createdPump = await repo.createPump(toCreate, '90');
      final expectedRes =
          toCreate.copyWith(id: createdPump?.id, companyId: '90');
      expect(
        createdPump,
        expectedRes,
      );
    });

    test('updatePump with existing pump works as expected', () async {
      final updatedValue = expectedResults[0].copyWith(
        commandForOff: '60',
        commandForOn: '80',
      );

      final repo = makePumpRepository();
      // access current value
      final currentVal = await repo.getPump(updatedValue.id);
      expect(currentVal, expectedResults[0]);

      // update value
      await repo.updatePump(updatedValue, updatedValue.companyId);
      final valueAfterUpdate = await repo.getPump(updatedValue.id);
      expect(valueAfterUpdate, updatedValue);
    });

    test('updatePump with non existing pump does not work as expected',
        () async {
      const updatedValue = Pump(
          id: '9000',
          name: 'Not valid pump',
          capacityInVolume: 100,
          consumeRateInKw: 50,
          commandForOn: '90',
          commandForOff: '91',
          companyId: '90');

      final repo = makePumpRepository();
      // access current value
      final currentVal = await repo.getPump(updatedValue.id);
      expect(currentVal, isNull);

      // update value
      await repo.updatePump(updatedValue, updatedValue.companyId);
      final valueAfterUpdate = await repo.getPump(updatedValue.id);
      expect(valueAfterUpdate, isNull);
    });

    test(
        'updatePump with existing pump but not pertaining to company does not work',
        () async {
      final updatedValue = expectedResults[0].copyWith(companyId: '500');

      final repo = makePumpRepository();
      // access current value
      final currentVal = await repo.getPump(updatedValue.id);
      expect(currentVal, expectedResults[0]);

      // update value
      final valueAfterUpdate = await repo.updatePump(
        updatedValue,
        updatedValue.companyId,
      );
      expect(valueAfterUpdate, isNull);
    });

    test('deletePump with an existing pump works', () async {
      final repo = makePumpRepository();
      final pumpToDelete = expectedResults[0];
      final currentVal = await repo.getPump(pumpToDelete.id);
      expect(currentVal, pumpToDelete);

      final returnedValFromDeletion = await repo.deletePump(pumpToDelete.id);
      final valueAfterDelete = await repo.getPump(pumpToDelete.id);
      expect(valueAfterDelete, isNull);
      expect(returnedValFromDeletion, equals(true));
    });

    test('deletePump with a non-existing pump does not work', () async {
      final repo = makePumpRepository();
      const pumpToDelete = Pump(
        id: '9000',
        name: 'Not valid pump',
        capacityInVolume: 100,
        consumeRateInKw: 50,
        commandForOn: '90',
        commandForOff: '91',
        companyId: '90',
      );
      final currentVal = await repo.getPump(pumpToDelete.id);
      expect(currentVal, isNull);

      final valFromDeletion = await repo.deletePump(pumpToDelete.id);
      final valueAfterDelete = await repo.getPump(pumpToDelete.id);
      expect(valueAfterDelete, isNull);
      expect(valFromDeletion, equals(false));
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
