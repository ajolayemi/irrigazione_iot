import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/service/add_update_sector_service.dart';

part 'add_update_sector_controller.g.dart';

@riverpod
class AddUpdateSectorController extends _$AddUpdateSectorController {
  @override
  FutureOr<void> build() {
    // nothing to do here
  }

  Future<bool> createSector(
      {Sector? sector, String? pumpIdToConnectToSector}) async {
    final sectorService = ref.read(addUpdateSectorServiceProvider);
    state = const AsyncLoading();
    if (sector == null) {
      state = AsyncError('Sector is null', StackTrace.current);
      return false;
    }

    if (pumpIdToConnectToSector == null) {
      state = AsyncError('PumpIdToConnectToSector is null', StackTrace.current);
      return false;
    }
    state = await AsyncValue.guard(
      () => sectorService.createSector(
        sector: sector,
        pumpIdToConnectToSector: pumpIdToConnectToSector,
      ),
    );
    return !state.hasError;
  }

  Future<bool> updateSector(
      {Sector? sector, String? updatedPumpIdToConnectToSector}) async {
    final sectorService = ref.read(addUpdateSectorServiceProvider);
    state = const AsyncLoading();
    if (sector == null) {
      state = AsyncError('Sector is null', StackTrace.current);
      return false;
    }

    if (updatedPumpIdToConnectToSector == null) {
      state = AsyncError(
          'UpdatedPumpIdToConnectToSector is null', StackTrace.current);
      return false;
    }
    state = await AsyncValue.guard(() => sectorService.updateSector(
          sector: sector,
          updatedConnectedPumpId: updatedPumpIdToConnectToSector,
        ));
    return !state.hasError;
  }
}
