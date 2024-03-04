import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pump_status_tile_wid_controller.g.dart';

@riverpod
class PumpStatusTileWidgetController extends _$PumpStatusTileWidgetController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<bool> confirmDismiss(PumpID pumpId) async {
    final pumpRepository = ref.read(pumpRepositoryProvider);
    state = const AsyncLoading<void>();
    final res = await AsyncValue.guard(() => pumpRepository.deletePump(pumpId));
    if (res.hasError) {
      state = AsyncError(res.error!, StackTrace.current);
      return false;
    }
    state = const AsyncData<void>(null);
    return true;
  }
}
