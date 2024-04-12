import '../data/sector_status_repository.dart';
import '../model/sector.dart';
import '../../../utils/custom_controller_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sector_switch_controller.g.dart';

@riverpod
class SectorSwitchController extends _$SectorSwitchController {
  final initState = const CustomControllerState(loadingStates: {});
  @override
  FutureOr<CustomControllerState> build() {
    state = AsyncData<CustomControllerState>(initState);
    return initState;
  }

  void setLoading(SectorID sectorId, bool isLoading) {
    state = AsyncData(state.value!.setLoading(sectorId, isLoading));
  }

  Future<void> toggleStatus(Sector sector, bool status) async {
    setLoading(sector.id, true);
    state = const AsyncLoading<CustomControllerState>().copyWithPrevious(state);
    final statusCommand = sector.getMqttStatusCommand(status);
    final sectorStatusRepository = ref.read(sectorStatusRepositoryProvider);
    final value = await AsyncValue.guard(
        () => sectorStatusRepository.toggleSectorStatus(sector, statusCommand));
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = AsyncData<CustomControllerState>(initState);
    }
  }
}
