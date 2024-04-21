import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';
import 'package:mocktail/mocktail.dart';

import 'package:irrigazione_iot/src/config/mock/fake_users_list.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/screen/sign_in/sign_in_controller.dart';

import '../../../../mocks.dart';

void main() {
  final testUserFromList = kFakeUsers[0];

  const emptyState = AsyncData<CustomControllerState>(
    CustomControllerState(loadingStates: {}),
  );

  ProviderContainer makeProviderContainer(MockAuthRepository authRepository) {
    final container = ProviderContainer(
        overrides: [authRepositoryProvider.overrideWithValue(authRepository)]);
    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<CustomControllerState>());
  });

  group('Email and password tests', () {
    test('Sign in was successful', () async {
      // setup stage
      const controllerStateWhenSigningIn = AsyncData<CustomControllerState>(
        CustomControllerState(
          loadingStates: {
            SignInController.signInStateKey: true,
          },
        ),
      );
      final authRepository = MockAuthRepository();

      // Stubbing sign in function
      when(
        () => authRepository.signInWithEmailAndPassword(
          testUserFromList.email,
          testUserFromList.password,
        ),
      ).thenAnswer((_) => Future.value());
      final providerContainer = makeProviderContainer(authRepository);
      final listener = Listener<AsyncValue<CustomControllerState>>();
      providerContainer.listen(
        signInControllerProvider,
        listener.call,
        fireImmediately: true,
      );
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
        // state value is immediately updated from null to an empty custom controller empty state
        () => listener(null, emptyState),

        // goes from empty state to state when logging in
        () => listener(emptyState, controllerStateWhenSigningIn),

        // then goes from state when logging in to loading state
        () => listener(
              controllerStateWhenSigningIn,
              const AsyncLoading<CustomControllerState>().copyWithPrevious(
                controllerStateWhenSigningIn,
              ),
            ),

        // data when complete
        () => listener(
            const AsyncLoading<CustomControllerState>().copyWithPrevious(
              controllerStateWhenSigningIn,
            ),
            emptyState),
      ]);
      //verifyNoMoreInteractions(listener);
    });

    test('Sign in failed', () async {
      // setup stage
      const controllerStateWhenSigningIn = AsyncData<CustomControllerState>(
        CustomControllerState(
          loadingStates: {
            SignInController.signInStateKey: true,
          },
        ),
      );
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
      final listener = Listener<AsyncValue<CustomControllerState>>();
      providerContainer.listen(
        signInControllerProvider,
        listener.call,
        fireImmediately: true,
      );

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
        // state value is immediately updated from null to an empty custom controller empty state
        () => listener(null, emptyState),

        // goes from empty state to state when logging in
        () => listener(emptyState, controllerStateWhenSigningIn),

        // then goes from state when logging in to loading state
        () => listener(
              controllerStateWhenSigningIn,
              const AsyncLoading<CustomControllerState>().copyWithPrevious(
                controllerStateWhenSigningIn,
              ),
            ),

        // data when complete
        () => listener(
            const AsyncLoading<CustomControllerState>().copyWithPrevious(
              controllerStateWhenSigningIn,
            ),
            any(that: isA<AsyncError>())),
      ]);
      //verifyNoMoreInteractions(listener);
    });
  });
}
