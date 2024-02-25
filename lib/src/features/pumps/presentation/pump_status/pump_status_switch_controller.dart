// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';

part 'pump_status_switch_controller.g.dart';


@riverpod
class PumpStatusSwitchController extends _$PumpStatusSwitchController {
  @override
  FutureOr<CustomControllerState> build() {
    const initValue = CustomControllerState(loadingStates: {});
    state = const AsyncData(initValue);
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
    final value = await AsyncValue.guard(
        () => pumpStatusRepository.togglePumpStatus(pump.id, statusCommand));
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      setLoading(pump.id, false);
    }
  }
}
