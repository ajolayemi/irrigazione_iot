import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/services/dismiss_sector_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dismiss_sector_controller.g.dart';

@riverpod
class DismissSectorController extends _$DismissSectorController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<bool> confirmDismiss(String sectorId) async {
    final sectorDismissalService = ref.read(dismissSectorServiceProvider);
    state = const AsyncLoading<void>();
    final res = await AsyncValue.guard(
        () => sectorDismissalService.dismissSector(sectorId));
    if (res.hasError) {
      state = AsyncError(res.error!, StackTrace.current);
      return false;
    }

    // Invalidate the list of sectors
    ref.invalidate(companySectorsFutureProvider);
    state = const AsyncData<void>(null);
    return true;
  }
}
