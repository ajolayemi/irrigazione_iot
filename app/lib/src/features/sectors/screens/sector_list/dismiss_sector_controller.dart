import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/services/dismiss_sector_service.dart';
import 'package:irrigazione_iot/src/utils/provider_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dismiss_sector_controller.g.dart';

@riverpod
class DismissSectorController extends _$DismissSectorController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<bool> confirmDismiss(Sector sector) async {
    final sectorDismissalService = ref.read(dismissSectorServiceProvider);
    state = const AsyncLoading<void>();
    final res = await AsyncValue.guard(() => sectorDismissalService.dismissSector(sector.id));
    if (res.hasError) {
      state = AsyncError(res.error!, StackTrace.current);
      return false;
    }

    // Invalidate the list of sectors
    ProviderUtils.invalidateSectorStates(ref: ref, sector: sector);
    state = const AsyncData<void>(null);
    return true;
  }
}
