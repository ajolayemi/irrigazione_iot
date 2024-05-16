import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station.dart';
import 'package:irrigazione_iot/src/features/weather_stations/services/add_update_weather_station_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_sensor_controller.g.dart';

@riverpod
class AddUpdateSensorController extends _$AddUpdateSensorController {
  @override
  FutureOr<void> build() {}

  Future<bool> createSensor(WeatherStation? sensor) async {
    final service = ref.read(addUpdateSensorServiceProvider);
    state = const AsyncLoading();
    if (sensor == null) {
      state = AsyncError('Sensor is null', StackTrace.current);
      return false;
    }

    state = await AsyncValue.guard(() => service.createWeatherStation(sensor));
    return !state.hasError;
  }

  Future<bool> updateSensor(WeatherStation? sensor) async {
    final service = ref.read(addUpdateSensorServiceProvider);
    state = const AsyncLoading();
    if (sensor == null) {
      state = AsyncError('Sensor is null', StackTrace.current);
      return false;
    }

    state = await AsyncValue.guard(() => service.updateWeatherStation(sensor));
    return !state.hasError;
  }
}
