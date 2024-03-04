import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/features/pumps/application/add_update_pump_service.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/add_pump/add_update_pump_controller.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  final testPump = kFakePumps[0];
  final testPumpForUpdate = testPump.copyWith(
    consumeRateInKw: 9000,
  );

  final service = MockAddUpdatePumpService();

  ProviderContainer makeProviderContainer() {
    final container = ProviderContainer(
      overrides: [
        addUpdatePumpServiceProvider.overrideWithValue(service),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<void>());
    registerFallbackValue(testPump);
  });

  group('AddUpdatePumpController', () {
    test('initial state should be AsyncData', () {
      // create container
      final container = makeProviderContainer();

      // create listener
      final listener = Listener<AsyncValue<void>>();

      // listen to changes in provider and call [listener]
      container.listen(
        addUpdatePumpControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      // verify
      verify(() => listener(null, const AsyncData<void>(null)));
      verifyNoMoreInteractions(listener);
    });
    group('createPump', () {
      test('throws', () async {
        // create container
        final container = makeProviderContainer();

        // create listener
        final listener = Listener<AsyncValue<void>>();

        final exception =
            Exception('An error occurred while trying to create pump');

        when(() => service.createPump(testPump)).thenThrow(exception);

        // listen to changes
        container.listen(
          addUpdatePumpControllerProvider,
          listener.call,
          fireImmediately: true,
        );

        // state data for testing
        const data = AsyncData<void>(null);

        // verify that current state is AsyncData
        verify(() => listener(null, data));

        // run
        final controller =
            container.read(addUpdatePumpControllerProvider.notifier);
        final res = await controller.createPump(testPump);
        verifyInOrder([
          // loading state
          () => listener(data, any(that: isA<AsyncLoading>())),
          // when complete
          () => listener(
              any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
        ]);

        // expect that the execution completes with an error
        // the controller function returns false when that happens
        expect(res, equals(false));

        verify(() => service.createPump(testPump)).called(1);
        verifyNever(() => service.updatePump(any()));
        verifyNoMoreInteractions(listener);
      });

      test('works', () async {
        // create container
        final container = makeProviderContainer();

        // create listener
        final listener = Listener<AsyncValue<void>>();

        when(() => service.createPump(testPump))
            .thenAnswer((_) => Future.value());

        // listen to changes
        container.listen(
          addUpdatePumpControllerProvider,
          listener.call,
          fireImmediately: true,
        );

        // state data for testing
        const data = AsyncData<void>(null);

        // verify that current state is AsyncData
        verify(() => listener(null, data));

        // run
        final controller =
            container.read(addUpdatePumpControllerProvider.notifier);
        final res = await controller.createPump(testPump);
        verifyInOrder([
          // loading state
          () => listener(data, any(that: isA<AsyncLoading>())),
          // when complete
          () => listener(any(that: isA<AsyncLoading>()), data),
        ]);

        // expect that the execution completes without error
        // the controller function returns true when that happens
        expect(res, equals(true));

        verify(() => service.createPump(testPump)).called(1);
        verifyNever(() => service.updatePump(any()));
        verifyNoMoreInteractions(listener);
      });
    });

    // ------------------ //

    group('updatePump', () {
      test('throws', () async {
        // create container
        final container = makeProviderContainer();

        // create listener
        final listener = Listener<AsyncValue<void>>();

        final exception =
            Exception('An error occurred while trying to update pump');

        when(() => service.updatePump(testPumpForUpdate)).thenThrow(exception);

        // listen to changes
        container.listen(
          addUpdatePumpControllerProvider,
          listener.call,
          fireImmediately: true,
        );

        // state data for testing
        const data = AsyncData<void>(null);

        // verify that current state is AsyncData
        verify(() => listener(null, data));

        // run
        final controller =
            container.read(addUpdatePumpControllerProvider.notifier);
        final res = await controller.updatePump(testPumpForUpdate);
        verifyInOrder([
          // loading state
          () => listener(data, any(that: isA<AsyncLoading>())),
          // when complete
          () => listener(
              any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
        ]);

        // expect that the execution completes with an error
        // the controller function returns false when that happens
        expect(res, equals(false));

        verify(() => service.updatePump(testPumpForUpdate)).called(1);
        verifyNever(() => service.createPump(any()));
        verifyNoMoreInteractions(listener);
      });

      test('works', () async {
        // create container
        final container = makeProviderContainer();

        // create listener
        final listener = Listener<AsyncValue<void>>();

        when(() => service.updatePump(testPumpForUpdate))
            .thenAnswer((_) => Future.value());

        // listen to changes
        container.listen(
          addUpdatePumpControllerProvider,
          listener.call,
          fireImmediately: true,
        );

        // state data for testing
        const data = AsyncData<void>(null);

        // verify that current state is AsyncData
        verify(() => listener(null, data));

        // run
        final controller =
            container.read(addUpdatePumpControllerProvider.notifier);
        final res = await controller.updatePump(testPumpForUpdate);
        verifyInOrder([
          // loading state
          () => listener(data, any(that: isA<AsyncLoading>())),
          // when complete
          () => listener(any(that: isA<AsyncLoading>()), data),
        ]);

        // expect that the execution completes without error
        // the controller function returns true when that happens
        expect(res, equals(true));

        verify(() => service.updatePump(testPumpForUpdate)).called(1);
        verifyNever(() => service.createPump(any()));
        verifyNoMoreInteractions(listener);
      });
    });
  });
}
