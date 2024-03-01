import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
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
    final pumpRepo = ref.read(pumpRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => pumpRepo.createPump(pump));
    return !state.hasError;
  }

  Future<bool> updatePump(Pump pump) async {
    final pumpRepo = ref.read(pumpRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => pumpRepo.updatePump(pump));
    return !state.hasError;
  }
}
