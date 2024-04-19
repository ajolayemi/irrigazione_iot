import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:irrigazione_iot/src/config/enums/irrigation_enums.dart';
import 'package:irrigazione_iot/src/config/mock/fake_companies_list.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sector_pumps.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sectors.dart';
import 'package:irrigazione_iot/src/config/mock/fake_users_list.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pump.dart';
import 'package:irrigazione_iot/src/features/sectors/service/add_update_sector_service.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_return_type.dart';

import '../../../mocks.dart';

void main() {
  final testUser = kFakeUsers.first;

  final testCompanyId = kFakeCompanies.first.id;
  // an arbitral existent sector for test cases
  final validSectorForTest = kFakeSectors
          .where((sector) => sector.companyId == testCompanyId)
          .toList()
          .firstOrNull
          ?.copyWith(createdAt: DateTime.parse('2024-01-01')) ??
      const Sector.empty();
  // a list of [SectorPump] pertaining to the chosen company sector
  final SectorPump validSectorPumpForTest = kFakeSectorPumps
      .firstWhere((sectorPump) => sectorPump.sectorId == validSectorForTest.id);

  final nonExistentSectorForTest = Sector(
      id: '200',
      companyId: testCompanyId,
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
      {RadioButtonReturnType? selectedPumpId}) {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(authRepository),
        sectorRepositoryProvider.overrideWithValue(sectorRepository),
        sectorPumpRepositoryProvider.overrideWithValue(sectorPumpRepository),
        selectedCompanyRepositoryProvider
            .overrideWithValue(selectedCompanyRepository),
        selectPumpRadioButtonProvider.overrideWith((ref) => selectedPumpId),
      ],
    );
    addTearDown(container.dispose);
    return container.read(addUpdateSectorServiceProvider);
  }

  setUpAll(() {
    registerFallbackValue(const Sector.empty());
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
        verifyNever(() => sectorRepository.createSector(any()));
        verifyNever(() => sectorPumpRepository.createSectorPump(any()));
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
          when(() => sectorRepository.createSector(nonExistentSectorForTest))
              .thenAnswer((_) => Future.value());

          final service = makeServiceWithArgs();

          // run
          await service.createSector(nonExistentSectorForTest);

          // verify that the following methods are called
          verify(() => authRepository.currentUser).called(1);
          verify(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .called(1);
          verify(() => sectorRepository.createSector(nonExistentSectorForTest))
              .called(1);

          // verify that the following isn't called
          verifyNever(
              () => sectorPumpRepository.createSectorPump(testSectorPump));
        });

        test(
            'all repository methods are called when a list of pump ids is provided',
            () async {
          // setup
          when(() => authRepository.currentUser).thenReturn(testUser);
          when(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .thenReturn(testCompanyId);
          when(() => sectorRepository.createSector(nonExistentSectorForTest))
              .thenAnswer((_) => Future.value(nonExistentSectorForTest));
          when(() => sectorPumpRepository.createSectorPump(any())).thenAnswer(
            (_) => Future.value(),
          );

          // A list of pumpIds are provided
          final service = makeServiceWithArgs(
              selectedPumpId:
                  RadioButtonReturnType(value: '1', label: 'Pompa 1'));

          // run
          await service.createSector(nonExistentSectorForTest);

          // verify that the following methods are called
          verify(() => authRepository.currentUser).called(1);
          verify(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .called(1);
          verify(() => sectorRepository.createSector(nonExistentSectorForTest))
              .called(1);
          verify(() => sectorPumpRepository.createSectorPump(any())).called(1);
        });

        test(
            "addSectorPump from sectorPumpRepository isn't called because addSector returned null",
            () async {
          // setup
          when(() => authRepository.currentUser).thenReturn(testUser);
          when(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .thenReturn(testCompanyId);
          when(() => sectorRepository.createSector(nonExistentSectorForTest))
              .thenAnswer((_) => Future.value());
          when(() => sectorPumpRepository.createSectorPump(any())).thenAnswer(
            (_) => Future.value(),
          );

          // A list of pumpIds are provided
          final service = makeServiceWithArgs(
              selectedPumpId:
                  RadioButtonReturnType(value: '1', label: 'Pompa 1'));

          // run
          await service.createSector(nonExistentSectorForTest);

          // verify that the following methods are called
          verify(() => authRepository.currentUser).called(1);
          verify(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .called(1);
          verify(() => sectorRepository.createSector(nonExistentSectorForTest))
              .called(1);
          verifyNever(() => sectorPumpRepository.createSectorPump(any()));
        });

        test(
            "addSectorPump from sectorPumpRepository isn't called because no pump ids was provided",
            () async {
          // setup
          when(() => authRepository.currentUser).thenReturn(testUser);
          when(() =>
                  selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
              .thenReturn(testCompanyId);
          when(() => sectorRepository.createSector(nonExistentSectorForTest))
              .thenAnswer((_) => Future.value(nonExistentSectorForTest));
          when(() => sectorPumpRepository.createSectorPump(any())).thenAnswer(
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
          verify(() => sectorRepository.createSector(nonExistentSectorForTest))
              .called(1);
          verifyNever(() => sectorPumpRepository.createSectorPump(any()));
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
        await service.updateSector(const Sector.empty());

        // verify that the following call is made
        verify(() => authRepository.currentUser).called(1);

        // verify that the following calls aren't made
        verifyNever(() => sectorRepository.createSector(any()));
        verifyNever(() => sectorRepository.updateSector(any()));
        verifyNever(() => sectorPumpRepository.getSectorPump(any()));
        verifyNever(() => sectorPumpRepository.deleteSectorPump(any()));
        verifyNever(() => sectorPumpRepository.createSectorPump(any()));
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
            () => sectorRepository.updateSector(nonExistentSectorForTest),
          ).thenAnswer((_) => Future.value());

          final service = makeServiceWithArgs(
              selectedPumpId:
                  RadioButtonReturnType(value: '9', label: 'Pump 9'));

          // run
          await service.updateSector(nonExistentSectorForTest);

          // verify that the following calls are made
          verify(() => authRepository.currentUser).called(1);
          verify(() => sectorRepository.updateSector(nonExistentSectorForTest))
              .called(1);

          // Verify that the following calls aren't made
          verifyNever(() => sectorPumpRepository.getSectorPump(any()));
          verifyNever(() => sectorPumpRepository.deleteSectorPump(any()));
          verifyNever(() => sectorPumpRepository.createSectorPump(any()));
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
          when(() => sectorRepository.updateSector(toUpdate)).thenAnswer(
            (_) => Future.value(toUpdate),
          );
          when(() => sectorPumpRepository.getSectorPump(toUpdate.id))
              .thenAnswer(
            (_) => Future.value(validSectorPumpForTest),
          );

          final service = makeServiceWithArgs(
              selectedPumpId: RadioButtonReturnType(
            value: validSectorPumpForTest.pumpId,
            label: 'Pump 9',
          ));

          // run
          await service.updateSector(toUpdate);

          // verify that the following methods are called
          verify(() => authRepository.currentUser).called(1);
          verify(() =>
              selectedCompanyRepository.loadSelectedCompanyId(testUser.uid));
          verify(() => sectorRepository.updateSector(toUpdate)).called(1);
          verify(() => sectorPumpRepository.getSectorPump(toUpdate.id))
              .called(1);

          // the following calls shouldn't be made
          verifyNever(
            () => sectorPumpRepository.deleteSectorPump(any()),
          );
          verifyNever(
            () => sectorPumpRepository.createSectorPump(any()),
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
          when(() => sectorRepository.updateSector(toUpdate)).thenAnswer(
            (_) => Future.value(toUpdate),
          );
          when(() => sectorPumpRepository.getSectorPump(toUpdate.id))
              .thenAnswer(
            (_) => Future.value(validSectorPumpForTest),
          );
          when(() => sectorPumpRepository.deleteSectorPump(any())).thenAnswer(
            (_) => Future.value(true),
          );
          when(() => sectorPumpRepository.createSectorPump(newSectorPumps))
              .thenAnswer(
            (_) => Future.value(newSectorPumps),
          );

          final service = makeServiceWithArgs(
              selectedPumpId: RadioButtonReturnType(
                  value: newSectorPumps.pumpId, label: 'Pump 90'));
          // run
          await service.updateSector(toUpdate);

          // verify that the following calls were made
          verify(() => authRepository.currentUser).called(1);
          verify(() => sectorRepository.updateSector(toUpdate)).called(1);
          verify(() => sectorPumpRepository.getSectorPump(toUpdate.id))
              .called(1);

          // verify that all previous pumps were deleted
          verify(() => sectorPumpRepository.deleteSectorPump(any())).called(1);
          // verify that new pump was added
          verify(() => sectorPumpRepository.createSectorPump(newSectorPumps))
              .called(1);
        });
      });
    });
  });
}
