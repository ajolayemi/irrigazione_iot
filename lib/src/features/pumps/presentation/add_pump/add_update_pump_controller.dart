import 'package:irrigazione_iot/src/features/pumps/application/add_update_pump_service.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_pump_controller.g.dart';

@riverpod
class AddUpdatePumpController extends _$AddUpdatePumpController {
  @override
  FutureOr<void> build() {
    // nothing to do here
  }

  Future<bool> addPump(Pump pump) async {
    final pumpService = ref.read(addUpdatePumpServiceProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => pumpService.createPump(pump));
    return !state.hasError;
  }

  Future<bool> updatePump(Pump pump) async {
    final pumpService = ref.read(addUpdatePumpServiceProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => pumpService.updatePump(pump));
    return !state.hasError;
  }
}
