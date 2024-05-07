import 'package:irrigazione_iot/src/features/sensors/data/sensor_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dismiss_sensor_controller.g.dart';

@riverpod
class DismissSensorController extends _$DismissSensorController {
  @override
  FutureOr<void> build() {}

  Future<bool> confirmDismiss(String sensorId) async {
    final sensorRepo = ref.read(sensorRepositoryProvider);
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard(() => sensorRepo.deleteSensor(sensorId));
    return !state.hasError;
  }
}
