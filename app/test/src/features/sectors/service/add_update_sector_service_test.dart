import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sector_pumps.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sectors.dart';
import 'package:mocktail/mocktail.dart';

import 'package:irrigazione_iot/src/config/enums/irrigation_enums.dart';
import 'package:irrigazione_iot/src/config/mock/fake_companies_list.dart';
import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/config/mock/fake_users_list.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pump.dart';
import 'package:irrigazione_iot/src/features/sectors/service/add_update_sector_service.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';

import '../../../mocks.dart';

void main() {
  final testUser = kFakeUsers.first;

  final testCompanyId = kFakeCompanies.first.id;

  final companyPumps = kFakePumps.where((pump) => pump.id == testCompanyId);
  // A general list of all pumps available in a particular company without distinction
  // of which sector they're connected to
  final companyPumpsIds = companyPumps.map((pump) => pump.id).toList();
  // an arbitral existent sector for test cases
  final validSectorForTest = kFakeSectors
          .where((sector) => sector.companyId == testCompanyId)
          .toList()
          .firstOrNull
          ?.copyWith(createdAt: DateTime.parse('2024-01-01')) ??
      Sector.empty();
  // a list of [SectorPump] pertaining to the chosen company sector
  final List<SectorPump> validSectorPumpForTest = kFakeSectorPumps
      .where((sectorPump) => sectorPump.sectorId == validSectorForTest.id)
      .toList();
  // a list of pumpsIds pertaining to the chosen company sector
  final validSectorPumpIdsForTest =
      validSectorPumpForTest.map((sp) => sp.pumpId).toList();

  final nonExistentSectorForTest = Sector(
      id: '200',
      companyId: '4',
      name: 'Sector for test',
      specieId: '1',
      varietyId: '3',
      area: 9000,
      numOfPlants: 20,
      waterConsumptionPerHour: 20,
      irrigationSystemType: IrrigationSystem.drip,
      irrigationSource: IrrigationSource.canal,
      turnOnCommand: '80',
      turnOffCommand: '81',
      notes: 'notes for sector',
      createdAt: DateTime.parse('2024-01-01'),
      updatedAt: DateTime.parse('2024-01-01'),
      mqttMsgName: 'sector_4_1',
      hasFilter: false);

  final testSectorPump = SectorPump(
    pumpId: '1',
    sectorId: '1',
    id: '1',
    createdAt: DateTime.parse('2022-01-01'),
  );

  final MockAuthRepository authRepository = MockAuthRepository();
  final MockSectorRepository sectorRepository = MockSectorRepository();
  final MockSectorPumpRepository sectorPumpRepository =
      MockSectorPumpRepository();
  final MockSelectedCompanyRepository selectedCompanyRepository =
      MockSelectedCompanyRepository();

  AddUpdateSectorService makeServiceWithArgs(
      {List<String> pumpIds = const []}) {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(authRepository),
        sectorRepositoryProvider.overrideWithValue(sectorRepository),
        sectorPumpRepositoryProvider.overrideWithValue(sectorPumpRepository),
        selectedCompanyRepositoryProvider
            .overrideWithValue(selectedCompanyRepository),
        selectedPumpsIdProvider.overrideWith((ref) => pumpIds),
      ],
    );
    addTearDown(container.dispose);
    return container.read(addUpdateSectorServiceProvider);
  }

  setUpAll(() {
    registerFallbackValue(Sector.empty());
    registerFallbackValue(testSectorPump);
  });

  group('AddUpdateSectorService', () {
    group('createSector', () {
      test(
          'null user - repository methods except authRepository are not called',
          () async {
        // setup
        when(() => authRepository.currentUser).thenReturn(null);

        final service = makeServiceWithArgs();

        // run
        await service.createSector(nonExistentSectorForTest);

        // verify that authRepository getter for currentUser is called
        verify(() => authRepository.currentUser).called(1);

        // the following calls shouldn't be made
        verifyNever(() => sectorRepository.addSector(any(), any()));
        verifyNever(() => sectorPumpRepository.addSectorPump(any()));
      });

      group('non null user', () {
        test(
            'all repository methods are called except for sectorPumpRepository',
            () async {
          // setup
          when(() => authRepository.currentUser).thenReturn(testUser);
          when(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .thenReturn(testCompanyId);
          when(() => sectorRepository.addSector(
                  nonExistentSectorForTest, testCompanyId))
              .thenAnswer((_) => Future.value());

          final service = makeServiceWithArgs();

          // run
          await service.createSector(nonExistentSectorForTest);

          // verify that the following methods are called
          verify(() => authRepository.currentUser).called(1);
          verify(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .called(1);
          verify(() => sectorRepository.addSector(
              nonExistentSectorForTest, testCompanyId)).called(1);

          // verify that the following isn't called
          verifyNever(() => sectorPumpRepository.addSectorPump(testSectorPump));
        });

        test(
            'all repository methods are called when a list of pump ids is provided',
            () async {
          // setup
          when(() => authRepository.currentUser).thenReturn(testUser);
          when(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .thenReturn(testCompanyId);
          when(() => sectorRepository.addSector(
                  nonExistentSectorForTest, testCompanyId))
              .thenAnswer((_) => Future.value(nonExistentSectorForTest));
          when(() => sectorPumpRepository.addSectorPump(any())).thenAnswer(
            (_) => Future.value(),
          );

          // A list of pumpIds are provided
          final service = makeServiceWithArgs(pumpIds: companyPumpsIds);

          // run
          await service.createSector(nonExistentSectorForTest);

          // verify that the following methods are called
          verify(() => authRepository.currentUser).called(1);
          verify(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .called(1);
          verify(() => sectorRepository.addSector(
              nonExistentSectorForTest, testCompanyId)).called(1);
          verify(() => sectorPumpRepository.addSectorPump(any()))
              .called(companyPumpsIds.length);
        });

        test(
            "addSectorPump from sectorPumpRepository isn't called because addSector returned null",
            () async {
          // setup
          when(() => authRepository.currentUser).thenReturn(testUser);
          when(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .thenReturn(testCompanyId);
          when(() => sectorRepository.addSector(
                  nonExistentSectorForTest, testCompanyId))
              .thenAnswer((_) => Future.value());
          when(() => sectorPumpRepository.addSectorPump(any())).thenAnswer(
            (_) => Future.value(),
          );

          // A list of pumpIds are provided
          final service = makeServiceWithArgs(pumpIds: companyPumpsIds);

          // run
          await service.createSector(nonExistentSectorForTest);

          // verify that the following methods are called
          verify(() => authRepository.currentUser).called(1);
          verify(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .called(1);
          verify(() => sectorRepository.addSector(
              nonExistentSectorForTest, testCompanyId)).called(1);
          verifyNever(() => sectorPumpRepository.addSectorPump(any()));
        });

        test(
            "addSectorPump from sectorPumpRepository isn't called because no pump ids was provided",
            () async {
          // setup
          when(() => authRepository.currentUser).thenReturn(testUser);
          when(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .thenReturn(testCompanyId);
          when(() => sectorRepository.addSector(
                  nonExistentSectorForTest, testCompanyId))
              .thenAnswer((_) => Future.value(nonExistentSectorForTest));
          when(() => sectorPumpRepository.addSectorPump(any())).thenAnswer(
            (_) => Future.value(),
          );
          final service = makeServiceWithArgs();

          // run
          await service.createSector(nonExistentSectorForTest);

          // verify that the following methods are called
          verify(() => authRepository.currentUser).called(1);
          verify(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .called(1);
          verify(() => sectorRepository.addSector(
              nonExistentSectorForTest, testCompanyId)).called(1);
          verifyNever(() => sectorPumpRepository.addSectorPump(any()));
        });
      });
    });

    group('updateSector', () {
      test("null user, repository methods except authRepository aren't called",
          () async {
        // setup
        when(() => authRepository.currentUser).thenReturn(null);

        final service = makeServiceWithArgs();

        // run
        // an empty sector can be passed here because the goal of this test isn't to test
        // the updateSector method from the service
        await service.updateSector(Sector.empty());

        // verify that the following call is made
        verify(() => authRepository.currentUser).called(1);

        // verify that the following calls aren't made
        verifyNever(() => sectorRepository.addSector(any(), any()));
        verifyNever(() => sectorRepository.updateSector(any(), any()));
        verifyNever(() => sectorPumpRepository.getSectorPumps(any()));
        verifyNever(() => sectorPumpRepository.deleteSectorPump(any(), any()));
        verifyNever(() => sectorPumpRepository.addSectorPump(any()));
      });

      group('non null user', () {
        test(
            "when update is called with non-existent sector, some repository methods aren't called",
            () async {
          // setup
          when(() => authRepository.currentUser).thenReturn(testUser);
          when(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .thenReturn(nonExistentSectorForTest.companyId);
          when(
            () => sectorRepository.updateSector(
                nonExistentSectorForTest, nonExistentSectorForTest.companyId),
          ).thenAnswer((_) => Future.value());

          final service = makeServiceWithArgs(pumpIds: ['9', '19']);

          // run
          await service.updateSector(nonExistentSectorForTest);

          // verify that the following calls are made
          verify(() => authRepository.currentUser).called(1);
          verify(() => sectorRepository.updateSector(
                  nonExistentSectorForTest, nonExistentSectorForTest.companyId))
              .called(1);

          // Verify that the following calls aren't made
          verifyNever(() => sectorPumpRepository.getSectorPumps(any()));
          verifyNever(
              () => sectorPumpRepository.deleteSectorPump(any(), any()));
          verifyNever(() => sectorPumpRepository.addSectorPump(any()));
        });

        test(
            '''when called with existing sector but with the same pumps as before, 
            - deleteSectorPump isn't called
            - addSectorPump isn't called ''', () async {
          final toUpdate = validSectorForTest.copyWith(
            area: 45000,
            numOfPlants: 400,
          );
          // setup
          when(() => authRepository.currentUser).thenReturn(testUser);
          when(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .thenReturn(testCompanyId);
          when(() => sectorRepository.updateSector(toUpdate, testCompanyId))
              .thenAnswer(
            (_) => Future.value(toUpdate),
          );
          when(() => sectorPumpRepository.getSectorPumps(toUpdate.id))
              .thenAnswer(
            (_) => Future.value(validSectorPumpForTest),
          );

          final service =
              makeServiceWithArgs(pumpIds: validSectorPumpIdsForTest);

          // run
          await service.updateSector(toUpdate);

          // verify that the following methods are called
          verify(() => authRepository.currentUser).called(1);
          verify(() =>
              selectedCompanyRepository.loadSelectedCompanyId(testUser.uid));
          verify(() => sectorRepository.updateSector(toUpdate, testCompanyId))
              .called(1);
          verify(() => sectorPumpRepository.getSectorPumps(toUpdate.id))
              .called(1);

          // the following calls shouldn't be made
          verifyNever(
            () => sectorPumpRepository.deleteSectorPump(any(), any()),
          );
          verifyNever(
            () => sectorPumpRepository.addSectorPump(any()),
          );
        });

        test(''' when called with existing sector and with different pumps
        - updateSector from sectorRepository is called
        - getSectorPumps from sectorPumpsRepository is called
        - deleteSectorPump from sectorPumpsRepository is called
        - addSectorPump from sectorPumpsRepository is called''', () async {
          final toUpdate = validSectorForTest.copyWith(
            area: 600,
            varietyId: '1',
            numOfPlants: 5600,
          );

          final newSectorPumps = SectorPump(
            pumpId: '90',
            sectorId: validSectorForTest.id,
            id: '',
          );

          // setup
          when(() => authRepository.currentUser).thenReturn(testUser);
          when(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .thenReturn(testCompanyId);
          when(() => sectorRepository.updateSector(toUpdate, testCompanyId))
              .thenAnswer(
            (_) => Future.value(toUpdate),
          );
          when(() => sectorPumpRepository.getSectorPumps(toUpdate.id))
              .thenAnswer(
            (_) => Future.value(validSectorPumpForTest),
          );
          when(() => sectorPumpRepository.deleteSectorPump(toUpdate.id, any()))
              .thenAnswer(
            (_) => Future.value(true),
          );
          when(() => sectorPumpRepository.addSectorPump(newSectorPumps))
              .thenAnswer(
            (_) => Future.value(newSectorPumps),
          );

          final service = makeServiceWithArgs(pumpIds: [newSectorPumps.pumpId]);
          // run
          await service.updateSector(toUpdate);

          // verify that the following calls were made
          verify(() => authRepository.currentUser).called(1);
          verify(() => sectorRepository.updateSector(toUpdate, testCompanyId))
              .called(1);
          verify(() => sectorPumpRepository.getSectorPumps(toUpdate.id))
              .called(1);

          // verify that all previous pumps were deleted
          verify(() =>
                  sectorPumpRepository.deleteSectorPump(toUpdate.id, any()))
              .called(validSectorPumpIdsForTest.length);
          // verify that new pump was added
          verify(() => sectorPumpRepository.addSectorPump(newSectorPumps))
              .called(1);
        });
      });
    });
  });
}
