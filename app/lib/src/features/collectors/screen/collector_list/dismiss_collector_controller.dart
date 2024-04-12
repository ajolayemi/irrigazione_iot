import '../../model/collector.dart';
import '../../service/dismiss_collector_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'dismiss_collector_controller.g.dart';


@riverpod
class DismissCollectorController extends _$DismissCollectorController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<bool> confirmDismiss(CollectorID collectorId) async {
    final collectorDismissalService = ref.read(dismissCollectorServiceProvider);
    state = const AsyncLoading<void>();
    final res = await AsyncValue.guard(
        () => collectorDismissalService.dismissCollector(collectorId));
    if (res.hasError) {
      state = AsyncError(res.error!, StackTrace.current);
      return false;
    }
    state = const AsyncData<void>(null);
    return true;
  }
}