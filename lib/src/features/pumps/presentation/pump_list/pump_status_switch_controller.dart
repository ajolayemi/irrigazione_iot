import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pump_status_switch_controller.g.dart';

@riverpod
class PumpStatusSwitchController extends _$PumpStatusSwitchController {
  @override
  FutureOr<void> build() {
    //
  }

  Future<void> toggleStatus(Pump pump, bool status) async {
    state = const AsyncLoading();
    final statusCommand = pump.getStatusCommand(status);
    final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
    state = await AsyncValue.guard(
        () => pumpStatusRepository.togglePumpStatus(pump.id, statusCommand));
  }
}
