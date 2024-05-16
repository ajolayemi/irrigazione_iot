import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/services/pump_status_service.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';

part 'pump_status_controller.g.dart';

@riverpod
class PumpStatusController extends _$PumpStatusController {
  final initValue = const CustomControllerState(loadingStates: {});
  @override
  FutureOr<CustomControllerState> build() {
    state = AsyncData<CustomControllerState>(initValue);
    return initValue;
  }

  void setLoading(String pumpId, bool isLoading) {
    state = AsyncData(state.value!.setLoading(pumpId, isLoading));
  }

  Future<void> toggleStatus(
    Pump pump,
    bool status,
  ) async {
    setLoading(pump.id, true);
    state = const AsyncLoading<CustomControllerState>().copyWithPrevious(state);
    final pumpStatusService = ref.read(pumpStatusServiceProvider);
    final value = await AsyncValue.guard(
        () => pumpStatusService.toggleStatus(pump: pump, status: status));
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = AsyncData<CustomControllerState>(initValue);
    }
  }
}
