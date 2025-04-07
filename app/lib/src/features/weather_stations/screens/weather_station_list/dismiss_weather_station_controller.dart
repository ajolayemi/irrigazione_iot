import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station.dart';
import 'package:irrigazione_iot/src/utils/provider_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dismiss_weather_station_controller.g.dart';

@riverpod
class DismissWeatherStationController
    extends _$DismissWeatherStationController {
  @override
  FutureOr<void> build() {}

  Future<bool> confirmDismiss(WeatherStation weatherStation) async {
    final repo = ref.read(weatherStationRepositoryProvider);
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard(
      () => repo.deleteWeatherStation(
        weatherStation.id,
      ),
    );

    final hasError = state.hasError;

    if (!hasError) {
      ProviderUtils.invalidateWeatherStationStates(
        ref: ref,
        weatherStation: weatherStation,
      );
    }
    return !hasError;
  }
}
