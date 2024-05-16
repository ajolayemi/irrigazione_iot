import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/authentication/role_management/data/role_management_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station.dart';
import 'package:irrigazione_iot/src/features/weather_stations/screens/weather_station_list/dismiss_weather_station_controller.dart';
import 'package:irrigazione_iot/src/features/weather_stations/widgets/weather_station_list_tile_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_dismissible.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

/// A list tile that displays weather station basic information.
class WeatherStationListTile extends ConsumerWidget {
  const WeatherStationListTile({
    super.key,
    required this.weatherStation,
  });

  final WeatherStation weatherStation;

  static Key weatherStationListTileKey(WeatherStation weatherStation) =>
      Key('weatherStationListTileKey_${weatherStation.id}');

  Future<bool> _dismissWeatherStation(
      BuildContext context, WidgetRef ref) async {
    final where = context.loc.nWeatherStationsWithArticulatedPreposition(1);
    if (await context.showDismissalDialog(where: where)) {
      return await ref
          .read(dismissWeatherStationControllerProvider.notifier)
          .confirmDismiss(weatherStation.id);
    }
    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeleting =
        ref.watch(dismissWeatherStationControllerProvider).isLoading;
    final canDelete =
        ref.watch(userCanDeleteStreamProvider).valueOrNull ?? false;

    return CustomDismissibleWidget(
      dismissibleKey: weatherStationListTileKey(weatherStation),
      canDelete: canDelete,
      isDeleting: isDeleting,
      confirmDismiss: (_) async => await _dismissWeatherStation(context, ref),
      child: WeatherStationListTileItem(
        weatherStation: weatherStation,
        isDeleting: isDeleting,
      ),
    );
  }
}
