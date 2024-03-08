import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_status/pump_status_tile_wid_controller.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  final pumpIdForTest = kFakePumps[0].id;
  final pumpRepository = MockPumpRepository();

  ProviderContainer makeProviderContainer() {
    final container = ProviderContainer(overrides: [
      pumpRepositoryProvider.overrideWithValue(pumpRepository),
    ]);

    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<void>());
  });

  group('PumpStatusTileWidgetController', () {
    test('initial state is AsyncData', () {
      // setup
      final container = makeProviderContainer();

      final listener = Listener<AsyncValue<void>>();

      container.listen(
        pumpStatusTileWidgetControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      // verify
      verify(() => listener(null, const AsyncData<void>(null)));
      verifyNoMoreInteractions(listener);
    });

    test('confirmDismiss works as expected', () async {
      // setup
      final container = makeProviderContainer();

      final controller =
          container.read(pumpStatusTileWidgetControllerProvider.notifier);

      // stub repository method called by this controller
      when(() => pumpRepository.deletePump(pumpIdForTest)).thenAnswer(
        (_) => Future.value(
          true,
        ),
      );

      final listener = Listener<AsyncValue<void>>();

      container.listen(
        pumpStatusTileWidgetControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      const stateForTest = AsyncData<void>(null);

      // verify initial state
      verify(() => listener(null, stateForTest));

      // run
      await controller.confirmDismiss(pumpIdForTest);

      verifyInOrder(
        [
          () => listener(stateForTest, any(that: isA<AsyncLoading>())),
          () => listener(any(that: isA<AsyncLoading>()), stateForTest)
        ],
      );

      verifyNoMoreInteractions(listener);
      verify(() => pumpRepository.deletePump(pumpIdForTest)).called(1);
    });

    test('confirmDismiss throws', () async {
      // setup
      final container = makeProviderContainer();

      final exception = Exception('Error occurred!!!');
      final controller = container.read(
        pumpStatusTileWidgetControllerProvider.notifier,
      );

      // stub repository method called by this controller
      when(() => pumpRepository.deletePump(pumpIdForTest)).thenThrow(exception);

      final listener = Listener<AsyncValue<void>>();

      container.listen(
        pumpStatusTileWidgetControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      const stateForTest = AsyncData<void>(null);

      // verify initial state
      verify(() => listener(null, stateForTest));

      // run
      await controller.confirmDismiss(pumpIdForTest);

      verifyInOrder(
        [
          () => listener(stateForTest, any(that: isA<AsyncLoading>())),
          () => listener(any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>()))
        ],
      );

      verifyNoMoreInteractions(listener);
      verify(() => pumpRepository.deletePump(pumpIdForTest)).called(1);
    });
  });
}
