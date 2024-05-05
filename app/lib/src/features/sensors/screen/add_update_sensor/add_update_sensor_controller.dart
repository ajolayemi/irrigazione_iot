import 'package:irrigazione_iot/src/features/sensors/model/sensor.dart';
import 'package:irrigazione_iot/src/features/sensors/service/add_update_sensor_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_sensor_controller.g.dart';

@riverpod
class AddUpdateSensorController extends _$AddUpdateSensorController {
  @override
  FutureOr<void> build() {}

  Future<bool> createSensor(Sensor? sensor) async {
    final service = ref.read(addUpdateSensorServiceProvider);
    state = const AsyncLoading();
    if (sensor == null) {
      state = AsyncError('Sensor is null', StackTrace.current);
      return false;
    }

    state = await AsyncValue.guard(() => service.createSensor(sensor));
    return !state.hasError;
  }

  Future<bool> updateSensor(Sensor? sensor) async {
    final service = ref.read(addUpdateSensorServiceProvider);
    state = const AsyncLoading();
    if (sensor == null) {
      state = AsyncError('Sensor is null', StackTrace.current);
      return false;
    }

    state = await AsyncValue.guard(() => service.updateSensor(sensor));
    return !state.hasError;
  }
}
