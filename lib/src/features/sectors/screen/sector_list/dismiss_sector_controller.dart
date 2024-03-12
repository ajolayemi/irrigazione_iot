import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/service/dismiss_sector_service.dart';

part 'dismiss_sector_controller.g.dart';

@riverpod
class DismissSectorController extends _$DismissSectorController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<bool> confirmDismiss(SectorID sectorId) async {
    final sectorDismissalService = ref.read(dismissSectorServiceProvider);
    state = const AsyncLoading<void>();
    final res = await AsyncValue.guard(
        () => sectorDismissalService.dismissSector(sectorId));
    if (res.hasError) {
      state = AsyncError(res.error!, StackTrace.current);
      return false;
    }
    state = const AsyncData<void>(null);
    return true;
  }
}
