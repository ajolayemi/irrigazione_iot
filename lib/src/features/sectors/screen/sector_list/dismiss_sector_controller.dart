

import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'dismiss_sector_controller.g.dart';

@riverpod
class DismissSectorController extends _$DismissSectorController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<bool> confirmDismiss(SectorID sectorId) async {
    final sectorRepository = ref.read(sectorsRepositoryProvider);
    state = const AsyncLoading<void>();
    final res = await AsyncValue.guard(() => sectorRepository.deleteSector(sectorId));
    if (res.hasError) {
      state = AsyncError(res.error!, StackTrace.current);
      return false;
    }
    state = const AsyncData<void>(null);
    return true;
  }
}