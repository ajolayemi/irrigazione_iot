import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dismiss_weather_station_controller.g.dart';

@riverpod
class DismissWeatherStationController
    extends _$DismissWeatherStationController {
  @override
  FutureOr<void> build() {}

  Future<bool> confirmDismiss(String weatherStationId) async {
    final repo = ref.read(weatherStationRepositoryProvider);
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard(
      () => repo.deleteWeatherStation(weatherStationId),
    );
    return !state.hasError;
  }
}
