import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/sector_list/dismiss_sector_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/service/dismiss_sector_service.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  const testSectorId = '1';

  final service = MockDismissSectorService();

  const emptySector = Sector.empty();

  ProviderContainer makeContainer() {
    return ProviderContainer(
      overrides: [
        dismissSectorServiceProvider.overrideWithValue(service),
      ],
    );
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<void>());
    registerFallbackValue(emptySector);
  });

  group('DismissSectorController', () {
    test('initial state is AsyncData<void>', () {
      final container = makeContainer();
      final listener = Listener<AsyncValue<void>>();
      addTearDown(container.dispose);
      container.listen(
        dismissSectorControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      final service = container.read(dismissSectorServiceProvider);

      verify(
        () => listener(
          null,
          const AsyncData<void>(null),
        ),
      );
      verifyNoMoreInteractions(listener);
      verifyNever(() => service.dismissSector(any()));
    });

    test('state during successful dismissal', () async {
      final container = makeContainer();
      final listener = Listener<AsyncValue<void>>();
      addTearDown(container.dispose);
      // setup
      container.listen(dismissSectorControllerProvider, listener.call,
          fireImmediately: true);

      const state = AsyncData<void>(null);

      final controller =
          container.read(dismissSectorControllerProvider.notifier);
      final service = container.read(dismissSectorServiceProvider);

      when(() => service.dismissSector(testSectorId))
          .thenAnswer((_) => Future.value());

      // verify initial state
      verify(() => listener(null, state));

      // run
      final returnedVal = await controller.confirmDismiss(testSectorId);

      expect(returnedVal, isTrue);
      verifyInOrder([
        () => listener(state, any(that: isA<AsyncLoading>())),
        () => listener(any(that: isA<AsyncLoading>()), state),
      ]);

      verifyNoMoreInteractions(listener);
      verify(() => service.dismissSector(testSectorId)).called(1);
    });

    test('state during failed dismissal', () async {
      final container = makeContainer();
      final listener = Listener<AsyncValue<void>>();
      addTearDown(container.dispose);
      // setup
      final exception = Exception('Failed to dismiss sector');
      container.listen(
        dismissSectorControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      const state = AsyncData<void>(null);

      final controller =
          container.read(dismissSectorControllerProvider.notifier);
      final service = container.read(dismissSectorServiceProvider);

      when(() => service.dismissSector(testSectorId)).thenThrow(exception);

      // verify initial state
      verify(() => listener(null, state));

      // run
      final returnedVal = await controller.confirmDismiss(testSectorId);

      expect(returnedVal, isFalse);
      verifyInOrder([
        () => listener(state, any(that: isA<AsyncLoading>())),
        () => listener(
              any(that: isA<AsyncLoading>()),
              any(that: isA<AsyncError>()),
            ),
      ]);

      verifyNoMoreInteractions(listener);
      verify(() => service.dismissSector(testSectorId)).called(1);
    });
  });
}
