import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/services/sector_status_service.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';

part 'sector_switch_controller.g.dart';

@riverpod
class SectorSwitchController extends _$SectorSwitchController {
  final initState = const CustomControllerState(loadingStates: {});
  @override
  FutureOr<CustomControllerState> build() {
    state = AsyncData<CustomControllerState>(initState);
    return initState;
  }

  void setLoading(String sectorId, bool isLoading) {
    state = AsyncData(state.value!.setLoading(sectorId, isLoading));
  }

  Future<void> toggleStatus(Sector sector, bool status) async {
    setLoading(sector.id, true);
    state = const AsyncLoading<CustomControllerState>().copyWithPrevious(state);
    final service = ref.read(sectorStatusServiceProvider);
    final value =
        await AsyncValue.guard(() => service.toggleStatus(sector: sector, status: status));
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = AsyncData<CustomControllerState>(initState);
    }
  }
}
