import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:irrigazione_iot/src/config/mock/fake_companies_list.dart';
import 'package:irrigazione_iot/src/config/mock/fake_users_list.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/service/add_update_pump_service.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';

import '../../../mocks.dart';

void main() {
  final testUser = kFakeUsers[0];
  final testPump = Pump(
    id: '90',
    name: 'Test Pump',
    capacityInVolume: 1000,
    consumeRateInKw: 1000,
    turnOnCommand: '91',
    turnOffCommand: '92',
    companyId: '93',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    mqttMessageName: 'test_pump',
    hasFilter: true,
  );
  final testCompanyId = kFakeCompanies[0].id;

  late MockAuthRepository authRepository;
  late MockPumpRepository pumpRepository;
  late MockSelectedCompanyRepository selectedCompanyRepository;

  setUp(() {
    authRepository = MockAuthRepository();
    pumpRepository = MockPumpRepository();
    selectedCompanyRepository = MockSelectedCompanyRepository();
    registerFallbackValue(const Pump.empty());
  });

  AddUpdatePumpService makeAddUpdateService() {
    final container = ProviderContainer(overrides: [
      authRepositoryProvider.overrideWithValue(authRepository),
      selectedCompanyRepositoryProvider
          .overrideWithValue(selectedCompanyRepository),
      pumpRepositoryProvider.overrideWithValue(pumpRepository),
    ]);

    addTearDown(container.dispose);
    return container.read(addUpdatePumpServiceProvider);
  }

  group('AddUpdatePumpService', () {
    group('createPump', () {
      test('null user, repository methods are not called ', () async {
        // setup
        when(() => authRepository.currentUser).thenReturn(null);
        final service = makeAddUpdateService();
        // run
        await service.createPump(testPump);

        // authRepo method is called
        verify(() => authRepository.currentUser).called(1);

        // the following calls aren't made
        verifyNever(() => pumpRepository.createPump(any()));
        verifyNever(
            () => selectedCompanyRepository.loadSelectedCompanyId(any()));
      });

      test('non null user, creates pump', () async {
        // setup
        when(() => authRepository.currentUser).thenReturn(testUser);
        when(() =>
                selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
            .thenReturn(testCompanyId);
        when(() => pumpRepository.createPump(any()))
            .thenAnswer((_) => Future.value(testPump));

        final service = makeAddUpdateService();

        // run
        await service.createPump(testPump);

        // verify
        verify(() => authRepository.currentUser).called(1);
        verify(() => selectedCompanyRepository.loadSelectedCompanyId(
              testUser.uid,
            )).called(1);
        verify(() => pumpRepository.createPump(
              any(),
            )).called(1);
      });
    });

    group('updatePump - ', () {
      test('null user, repository methods are not called', () async {
        when(() => authRepository.currentUser).thenReturn(null);

        final service = makeAddUpdateService();

        await service.updatePump(testPump);

        // authRepo method is called
        verify(() => authRepository.currentUser).called(1);

        // the following calls shouldn't be made
        verifyNever(
            () => selectedCompanyRepository.loadSelectedCompanyId(any()));
        verifyNever(() => pumpRepository.updatePump(any()));
      });

      test('non null user, pump data is updated', () async {
        final updatedTestPump = testPump.copyWith(
          turnOffCommand: '45',
          turnOnCommand: '56',
        );
        // setup
        when(() => authRepository.currentUser).thenReturn(testUser);
        when(() =>
                selectedCompanyRepository.loadSelectedCompanyId(testUser.uid))
            .thenReturn(testCompanyId);
        when(() => pumpRepository.updatePump(any()))
            .thenAnswer((_) => Future.value(updatedTestPump));

        final service = makeAddUpdateService();
        // run
        await service.updatePump(updatedTestPump);

        // verify that the necessary calls are made
        verify(() => authRepository.currentUser).called(1);
        verify(
          () => selectedCompanyRepository.loadSelectedCompanyId(testUser.uid),
        ).called(1);
        verify(() => pumpRepository.updatePump(any()))
            .called(1);
      });
    });
  });
}
