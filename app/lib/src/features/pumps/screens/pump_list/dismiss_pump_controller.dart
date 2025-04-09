import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/utils/provider_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dismiss_pump_controller.g.dart';

@riverpod
class DismissPumpController extends _$DismissPumpController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<bool> confirmDismiss(Pump pump) async {
    final pumpRepository = ref.read(pumpRepositoryProvider);
    state = const AsyncLoading<void>();
    final res = await AsyncValue.guard(() => pumpRepository.deletePump(pump.id));
    if (res.hasError) {
      state = AsyncError(res.error!, StackTrace.current);
      return false;
    }

    ProviderUtils.invalidatePumpStates(ref: ref, pump: pump);
    state = const AsyncData<void>(null);
    return true;
  }
}
