import 'package:irrigazione_iot/src/features/sectors/application/add_update_sector_service.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_sector_controller.g.dart';

@riverpod
class AddUpdateSectorController extends _$AddUpdateSectorController {
  @override
  FutureOr<void> build() {
    // nothing to do here
  }

  Future<bool> createSector(Sector sector) async {
    final sectorService = ref.read(addUpdateSectorServiceProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => sectorService.createSector(sector));
    return !state.hasError;
  }

  Future<bool> updateSector(Sector sector) async {
    final sectorService = ref.read(addUpdateSectorServiceProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => sectorService.updateSector(sector));
    return !state.hasError;
  }
}