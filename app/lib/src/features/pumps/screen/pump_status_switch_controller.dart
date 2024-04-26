import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pump_status_switch_controller.g.dart';

@riverpod
class PumpStatusSwitchController extends _$PumpStatusSwitchController {
  final initValue = const CustomControllerState(loadingStates: {});
  @override
  FutureOr<CustomControllerState> build() {
    state = AsyncData<CustomControllerState>(initValue);
    return initValue;
  }

  void setLoading(String pumpId, bool isLoading) {
    state = AsyncData(state.value!.setLoading(pumpId, isLoading));
  }

  Future<void> toggleStatus(Pump pump, bool status) async {
    setLoading(pump.id, true);
    state = const AsyncLoading<CustomControllerState>().copyWithPrevious(state);
    final statusCommand = pump.getStatusCommand(status);
    final pumpStatusRepository = ref.read(pumpStatusRepositoryProvider);
    final value =
        await AsyncValue.guard(() => pumpStatusRepository.togglePumpStatus(
              pumpId: pump.id,
              statusBoolean: status,
              statusString: statusCommand,
            ));
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = AsyncData<CustomControllerState>(initValue);
    }
  }
}
