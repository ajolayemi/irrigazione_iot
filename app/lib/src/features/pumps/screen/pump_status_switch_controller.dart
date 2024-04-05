// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../utils/custom_controller_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/pump_status_repository.dart';
import '../model/pump.dart';

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
    final value = await AsyncValue.guard(
        () => pumpStatusRepository.togglePumpStatus(pump, statusCommand));
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = AsyncData<CustomControllerState>(initValue);
    }
  }
}
