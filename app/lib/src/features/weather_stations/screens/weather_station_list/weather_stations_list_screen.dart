import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station.dart';
import 'package:irrigazione_iot/src/features/weather_stations/screens/weather_station_list/dismiss_weather_station_controller.dart';
import 'package:irrigazione_iot/src/features/weather_stations/widgets/weather_station_list_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_sliver_list_skeleton.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_data_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

// Displays a list of weather stations
class WeatherStationListScreen extends ConsumerWidget {
  const WeatherStationListScreen({super.key});

  void _onTapAdd(BuildContext context) =>
      context.pushNamed(AppRoute.addWeatherStation.name);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      dismissWeatherStationControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final loc = context.loc;
    final weatherStations = ref.watch(weatherStationsStreamProvider);

    return Scaffold(
      body: PaddedSafeArea(
        child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: loc.weatherStationPageTitle,
              actions: [
                CommonAddIconButton(
                  onPressed: () => _onTapAdd(context),
                )
              ],
            ),
            AsyncValueSliverWidget<List<WeatherStation>?>(
              value: weatherStations,
              data: (data) {
                if (data == null || data.isEmpty) {
                  return SliverFillRemaining(
                    child: EmptyDataWidget(
                      message:
                          loc.emptyDataPlaceholder(loc.nWeatherStations(1)),
                      buttonText: loc.addNewButtonLabel,
                      onPressed: () => _onTapAdd(context),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final weatherStation = data[index];
                      return WeatherStationListTile(
                          weatherStation: weatherStation);
                    },
                    childCount: data.length,
                  ),
                );
              },
              loading: () => const CommonSliverListSkeleton(),
            )
          ],
        ),
      ),
    );
  }
}
