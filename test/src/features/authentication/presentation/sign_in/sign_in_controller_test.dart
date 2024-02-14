import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:irrigazione_iot/src/config/mock/fake_users_list.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/presentation/sign_in/sign_in_controller.dart';

import '../../../../mocks.dart';

void main() {
  final testUserFromList = kFakeUsers[0];


  ProviderContainer makeProviderContainer(MockAuthRepository authRepository) {
    final container = ProviderContainer(
        overrides: [authRepositoryProvider.overrideWithValue(authRepository)]);
    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<int>());
  });

  group('Email and password tests', () {
    test('Sign in was successful', () async {
      // setup stage
      final authRepository = MockAuthRepository();

      // Stubbing sign in function
      when(
        () => authRepository.signInWithEmailAndPassword(
          testUserFromList.email,
          testUserFromList.password,
        ),
      ).thenAnswer((_) => Future.value());
      final providerContainer = makeProviderContainer(authRepository);
      final listener = Listener<AsyncValue<void>>();
      providerContainer.listen(
        signInControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      const data = AsyncData<void>(null);

      // verify that the initial value from build is null, i.e the build function
      // of the sign in controller
      verify(() => listener(null, data));

      // run
      final controller = providerContainer.read(
        signInControllerProvider.notifier,
      );

      final result = await controller.authenticateWithEmailAndPassword(
        testUserFromList.email,
        testUserFromList.password,
      );

      // Expect that the result is true
      expect(result, true);

      // verify the states of the controller
      verifyInOrder([
        // set loading state, initial state
        () => listener(data, any(that: isA<AsyncLoading>())),
        // data when complete
        () => listener(any(that: isA<AsyncLoading>()), data),
      ]);
      verifyNoMoreInteractions(listener);
    });

    test('Sign in failed', () async {
      // setup stage
      final authRepository = MockAuthRepository();

      final exception = Exception('Sign in failed');

      // Stubbing sign in function
      when(
        () => authRepository.signInWithEmailAndPassword(
          testUserFromList.email,
          testUserFromList.password,
        ),
      ).thenThrow(exception);
      final providerContainer = makeProviderContainer(authRepository);
      final listener = Listener<AsyncValue<void>>();
      providerContainer.listen(
        signInControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      const data = AsyncData<void>(null);

      // verify that the initial value from build is null, i.e the build function
      // of the sign in controller
      verify(() => listener(null, data));

      // run
      final controller = providerContainer.read(
        signInControllerProvider.notifier,
      );

      final result = await controller.authenticateWithEmailAndPassword(
        testUserFromList.email,
        testUserFromList.password,
      );

      // Expect that the result is false
      expect(result, false);

      // verify the states of the controller
      verifyInOrder([
        // set loading state, initial state
        () => listener(data, any(that: isA<AsyncLoading>())),
        // data when complete
        () => listener(
            any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
      ]);
      verifyNoMoreInteractions(listener);
    });
  });
}
