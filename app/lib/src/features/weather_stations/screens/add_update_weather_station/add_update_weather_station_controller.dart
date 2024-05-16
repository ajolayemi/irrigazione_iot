import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station.dart';
import 'package:irrigazione_iot/src/features/weather_stations/services/add_update_weather_station_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_weather_station_controller.g.dart';

@riverpod
class AddUpdateWeatherStationController
    extends _$AddUpdateWeatherStationController {
  @override
  FutureOr<void> build() {}

  Future<bool> createWeatherStation(WeatherStation? weatherStation) async {
    final service = ref.read(addUpdateWeatherStationServiceProvider);
    state = const AsyncLoading();
    if (weatherStation == null) {
      state = AsyncError('Weather station is null', StackTrace.current);
      return false;
    }

    state = await AsyncValue.guard(
        () => service.createWeatherStation(weatherStation));
    return !state.hasError;
  }

  Future<bool> updateWeatherStation(WeatherStation? weatherStation) async {
    final service = ref.read(addUpdateWeatherStationServiceProvider);
    state = const AsyncLoading();
    if (weatherStation == null) {
      state = AsyncError('Weather station is null', StackTrace.current);
      return false;
    }

    state = await AsyncValue.guard(() => service.updateWeatherStation(weatherStation));
    return !state.hasError;
  }
}
