import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/collectors/service/add_update_collector_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_collector_controller.g.dart';

@riverpod
class AddUpdateCollectorController extends _$AddUpdateCollectorController {
  @override
  FutureOr<void> build() {
    // nothing to do here
  }

  Future<bool> createCollector({required Collector? collectorToCreate}) async {
    final collectorService = ref.read(addUpdateCollectorServiceProvider);
    state = const AsyncLoading();
    if (collectorToCreate == null) {
      state = AsyncError(
        'no collector object provided for creation',
        StackTrace.current,
      );
      return Future.value(false);
    }
    state = await AsyncValue.guard(
        () => collectorService.createCollector(collectorToCreate));
    return !state.hasError;
  }

  Future<bool> updateCollector({required Collector? collectorToUpdate}) async {
    final collectorService = ref.read(addUpdateCollectorServiceProvider);
    state = const AsyncLoading();
    if (collectorToUpdate == null) {
      state = AsyncError(
        'no collector object provided for update',
        StackTrace.current,
      );
      return false;
    }

    state = await AsyncValue.guard(
        () => collectorService.updateCollector(collectorToUpdate));
    return !state.hasError;
  }
}
