import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_status_controller.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  final testPump = kFakePumps[0];

  const companyMqttTopicName = 'valenziani';

  final commandToSwitchOn = testPump.getStatusCommand(true);

  final pumpStatusRepository = MockPumpStatusRepository();

  ProviderContainer makeProviderContainer() {
    final container = ProviderContainer(overrides: [
      pumpStatusRepositoryProvider.overrideWithValue(pumpStatusRepository),
    ]);
    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<CustomControllerState>());
    registerFallbackValue(testPump);
  });

  group('PumpStatusSwitchController', () {
    test('initial state should be AsyncData<CustomControllerState>', () {
      final container = makeProviderContainer();

      final listener = Listener<AsyncValue<CustomControllerState>>();

      container.listen(
        pumpStatusControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      verify(() => listener(
            null,
            const AsyncData<CustomControllerState>(
                CustomControllerState(loadingStates: {})),
          ));
      verifyNoMoreInteractions(listener);
    });

    test('toggleStatus works for switch on', () async {
      // setup
      final customStateWhenTogglingStatus = AsyncData<CustomControllerState>(
        CustomControllerState(
          loadingStates: {testPump.id: true},
        ),
      );

      final container = makeProviderContainer();

      final controller =
          container.read(pumpStatusControllerProvider.notifier);

      final listener = Listener<AsyncValue<CustomControllerState>>();

      container.listen(
        pumpStatusControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      final statusBool = testPump.turnOnCommand == commandToSwitchOn;

      when(
        () => pumpStatusRepository.togglePumpStatus(
          pumpId: testPump.id,
          statusBoolean: statusBool,
          statusString: commandToSwitchOn,
          companyMqttTopicName: companyMqttTopicName,
        ),
      ).thenAnswer((_) => Future.value());

      // run
      const initialData = AsyncData<CustomControllerState>(
          CustomControllerState(loadingStates: {}));

      // verify that initial state is the expected one
      verify(() => listener(null, initialData));

      // toggle status
      await controller.toggleStatus(testPump, true, companyMqttTopicName);
      // verify
      verifyInOrder([
        // state value is immediately updated
        () => listener(initialData, customStateWhenTogglingStatus),

        // then state is passed over to loading state
        () => listener(
            customStateWhenTogglingStatus,
            const AsyncLoading<CustomControllerState>()
                .copyWithPrevious(customStateWhenTogglingStatus)),

        // then state is reset to initial state
        () => listener(
              const AsyncLoading<CustomControllerState>()
                  .copyWithPrevious(customStateWhenTogglingStatus),
              initialData,
            )
      ]);
    });

    // -------------------------------------------- //
    test('toggleStatus throws when switching on', () async {
      // setup
      final customStateWhenTogglingStatus = AsyncData<CustomControllerState>(
        CustomControllerState(
          loadingStates: {testPump.id: true},
        ),
      );

      final container = makeProviderContainer();

      final controller =
          container.read(pumpStatusControllerProvider.notifier);

      final listener = Listener<AsyncValue<CustomControllerState>>();

      container.listen(
        pumpStatusControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      final exception = Exception('Error occurred when switching on pump');

      final statusBool = testPump.turnOnCommand == commandToSwitchOn;

      when(
        () => pumpStatusRepository.togglePumpStatus(
          pumpId: testPump.id,
          statusBoolean: statusBool,
          statusString: commandToSwitchOn,
          companyMqttTopicName: companyMqttTopicName,
        ),
      ).thenThrow(exception);

      // run
      const initialData = AsyncData<CustomControllerState>(
          CustomControllerState(loadingStates: {}));

      // verify that initial state is the expected one
      verify(() => listener(null, initialData));

      // toggle status
      await controller.toggleStatus(testPump, true, companyMqttTopicName);
      // verify
      verifyInOrder([
        // state value is immediately updated
        () => listener(initialData, customStateWhenTogglingStatus),

        // then state is passed over to loading state
        () => listener(
            customStateWhenTogglingStatus,
            const AsyncLoading<CustomControllerState>()
                .copyWithPrevious(customStateWhenTogglingStatus)),

        // then state is reset to initial state
        () => listener(
              const AsyncLoading<CustomControllerState>()
                  .copyWithPrevious(customStateWhenTogglingStatus),
              any(that: isA<AsyncError>()),
            )
      ]);
    });
  });
}
