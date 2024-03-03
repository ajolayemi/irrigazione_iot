import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/presentation/user_company_list/user_companies_controller.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late MockSelectedCompanyRepository selectedCompanyRepository;

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<void>());
    authRepository = MockAuthRepository();
    selectedCompanyRepository = MockSelectedCompanyRepository();
  });

  // make provider container since the controller that is being tested
  // accesses some repos provider
  ProviderContainer makeProviderContainer() {
    final container = ProviderContainer(overrides: [
      authRepositoryProvider.overrideWithValue(authRepository),
      selectedCompanyRepositoryProvider
          .overrideWithValue(selectedCompanyRepository),
    ]);
    addTearDown(container.dispose);
    return container;
  }

  group('UserCompaniesController', () {
    test('initial state is AsyncData', () {
      // create container
      final container = makeProviderContainer();
      // create a listener
      final listener = Listener<AsyncValue<void>>();
      // listen to the provider and call [listener] when its value change
      container.listen(
        userCompaniesControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      // verify
      verify(
        // the build method returns a value immediately, which should be an AsyncData
        () => listener(null, const AsyncData<void>(null)),
      );
      // verify that the listener is no more called
      // that is so because the controller's value was not modified by any means
      verifyNoMoreInteractions(listener);
    });

    test('updateTappedCompanyId works', () async {
      // create container
      final container = makeProviderContainer();
      // create a listener
      final listener = Listener<AsyncValue<void>>();
      // listen to the provider and call [listener] whenever its value changes
      container.listen(
        userCompaniesControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      // state data for testing
      const data = AsyncData<void>(null);

      // current state should be data since the provider is fired immediately
      verify(() => listener(null, data));

      final controller =
          container.read(userCompaniesControllerProvider.notifier);

      when(() =>
              selectedCompanyRepository.updateSelectedCompanyId(any(), any()))
          .thenAnswer((_) => Future.value());

      await controller.updateTappedCompanyId('1');

      // verify state
      verifyInOrder([
        // loading state
        () => listener(data, any(that: isA<AsyncLoading>())),
        // when complete
        () => listener(any(that: isA<AsyncLoading>()), data),
      ]);

      verifyNoMoreInteractions(listener);
      verify(
        () => selectedCompanyRepository.updateSelectedCompanyId(any(), any()),
      ).called(1);

      // loadSelectedCompanyId is called because the provider that listens
      // to the underline provider is invalidated by this controller
      verify(() => selectedCompanyRepository.loadSelectedCompanyId(any()))
          .called(1);
    });

    test('updateTappedCompanyId fails', () async {
      final container = makeProviderContainer();
      // create a listener
      final listener = Listener<AsyncValue<void>>();
      // listen to the provider and call [listener] whenever its value changes
      container.listen(
        userCompaniesControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      // state data for testing
      const data = AsyncData<void>(null);

      // current state should be data since the provider is fired immediately
      verify(() => listener(null, data));

      final exception = Exception('Shared Preferences error occurred');

      final controller =
          container.read(userCompaniesControllerProvider.notifier);

      when(() =>
              selectedCompanyRepository.updateSelectedCompanyId(any(), any()))
          .thenThrow(
        exception,
      );

      await controller.updateTappedCompanyId('1');

      verifyInOrder([
        () => listener(data, any(that: isA<AsyncLoading>())),
        () => listener(
              any(that: isA<AsyncLoading>()),
              any(that: isA<AsyncError>()),
            )
      ]);

      verifyNoMoreInteractions(listener);
      verify(() =>
              selectedCompanyRepository.updateSelectedCompanyId(any(), any()))
          .called(1);
      // loadSelectedCompanyId is called because the provider that listens
      // to the underline provider is invalidated by this controller
      verify(() => selectedCompanyRepository.loadSelectedCompanyId(any()))
          .called(1);
    });
  });
}
