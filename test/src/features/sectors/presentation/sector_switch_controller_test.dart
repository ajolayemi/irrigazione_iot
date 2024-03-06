import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sectors.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/presentation/sector_switch_controller.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  final testSector = kFakeSectors[0];
  final testSectorId = testSector.id;
  final testSectorCommandForSwitchOn = testSector.getMqttStatusCommand(true);
  final sectorStatusRepository = MockSectorStatusRepository();

  ProviderContainer makeProviderContainer() {
    final container = ProviderContainer(overrides: [
      sectorStatusRepositoryProvider.overrideWithValue(sectorStatusRepository),
    ]);
    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<CustomControllerState>());
    registerFallbackValue(testSector);
  });

  group('SectorSwitchController', () {
    test('initial value is AsyncData<CustomControllerState>', () {
      final container = makeProviderContainer();

      final listener = Listener<AsyncValue<CustomControllerState>>();

      container.listen(
        sectorSwitchControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      verify(
        () => listener(
          null,
          const AsyncData<CustomControllerState>(
              CustomControllerState(loadingStates: {})),
        ),
      );

      verifyNoMoreInteractions(listener);
      verifyNever(
        () => sectorStatusRepository.toggleSectorStatus(any(), any()),
      );
    });

    test('toggleStatus works when switching on', () async {
      // setup
      final customStateWhenSwitchingOn = AsyncData<CustomControllerState>(
        CustomControllerState(
          loadingStates: {
            testSectorId: true,
          },
        ),
      );

      final container = makeProviderContainer();

      final controller =
          container.read(sectorSwitchControllerProvider.notifier);

      final listener = Listener<AsyncValue<CustomControllerState>>();

      container.listen(
        sectorSwitchControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      when(() => sectorStatusRepository.toggleSectorStatus(
          testSector, testSectorCommandForSwitchOn)).thenAnswer(
        (_) => Future.value(),
      );

      // run
      const initialState = AsyncData<CustomControllerState>(
        CustomControllerState(loadingStates: {}),
      );

      // verify initial state
      verify(() => listener(null, initialState));

      // toggle status
      await controller.toggleStatus(
        testSector,
        true,
      );

      // verify states
      verifyInOrder([
        // state value is immediately updated
        () => listener(initialState, customStateWhenSwitchingOn),

        // then state is passed over to loading state
        () => listener(
            customStateWhenSwitchingOn,
            const AsyncLoading<CustomControllerState>()
                .copyWithPrevious(customStateWhenSwitchingOn)),

        // then state is reset to initial state
        () => listener(
              const AsyncLoading<CustomControllerState>()
                  .copyWithPrevious(customStateWhenSwitchingOn),
              initialState,
            )
      ]);

      verifyNoMoreInteractions(listener);
      verify(() => sectorStatusRepository.toggleSectorStatus(
            testSector,
            testSectorCommandForSwitchOn,
          )).called(1);
    });

    test('toggleStatus throws when switching on', () async {
      // setup
      final customStateWhenSwitchingOn = AsyncData<CustomControllerState>(
        CustomControllerState(
          loadingStates: {
            testSectorId: true,
          },
        ),
      );

      final exception = Exception('Error occurred while switching on sector');
      final container = makeProviderContainer();

      final controller =
          container.read(sectorSwitchControllerProvider.notifier);

      final listener = Listener<AsyncValue<CustomControllerState>>();

      container.listen(
        sectorSwitchControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      when(() => sectorStatusRepository.toggleSectorStatus(
          testSector, testSectorCommandForSwitchOn)).thenThrow(exception);

      // run
      const initialState = AsyncData<CustomControllerState>(
        CustomControllerState(loadingStates: {}),
      );

      // verify initial state
      verify(() => listener(null, initialState));

      // toggle status
      await controller.toggleStatus(
        testSector,
        true,
      );

      // verify states
      verifyInOrder([
        // state value is immediately updated
        () => listener(initialState, customStateWhenSwitchingOn),

        // then state is passed over to loading state
        () => listener(
            customStateWhenSwitchingOn,
            const AsyncLoading<CustomControllerState>()
                .copyWithPrevious(customStateWhenSwitchingOn)),

        // then state is reset to initial state
        () => listener(
              const AsyncLoading<CustomControllerState>()
                  .copyWithPrevious(customStateWhenSwitchingOn),
              any(that: isA<AsyncError>())
            )
      ]);

      verifyNoMoreInteractions(listener);
      verify(() => sectorStatusRepository.toggleSectorStatus(
            testSector,
            testSectorCommandForSwitchOn,
          )).called(1);
    });
  });
}
