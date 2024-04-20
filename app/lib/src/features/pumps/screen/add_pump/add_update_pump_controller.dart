import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/service/add_update_pump_service.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_pump_controller.g.dart';

@riverpod
class AddUpdatePumpController extends _$AddUpdatePumpController {
  @override
  FutureOr<void> build() {
    // nothing to do here
  }

  Future<bool> createPump(Pump pump) async {
    final pumpService = ref.read(addUpdatePumpServiceProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => pumpService.createPump(pump));
    // invalidate the available pumps so that the newly created pump is included
    ref.invalidate(availablePumpsFutureProvider);
    return !state.hasError;
  }

  Future<bool> updatePump(Pump pump) async {
    final pumpService = ref.read(addUpdatePumpServiceProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => pumpService.updatePump(pump));
    // invalidate the available pumps so that the updated pump is included
    ref.invalidate(availablePumpsFutureProvider);
    return !state.hasError;
  }
}
