import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station.dart';
import 'package:irrigazione_iot/src/features/weather_stations/widgets/weather_station_details_characteristics.dart';
import 'package:irrigazione_iot/src/features/weather_stations/widgets/weather_station_details_last_update_card.dart';
import 'package:irrigazione_iot/src/features/weather_stations/widgets/weather_station_details_statistics.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_edit_icon_button.dart';

class WeatherStationDetailsScreenContents extends StatelessWidget {
  const WeatherStationDetailsScreenContents({
    super.key,
    required this.weatherStation,
  });

  final WeatherStation weatherStation;

  void _onTapEdit(BuildContext context) {
    final param = PathParameters(id: weatherStation.id).toJson();

    context.pushNamed(
      AppRoute.updateWeatherStation.name,
      pathParameters: param,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AppSliverBar(
          title: weatherStation.name,
          actions: [
            CommonEditIconButton(
              onPressed: () => _onTapEdit(context),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              WeatherStationDetailsLastUpdateCard(
                weatherStationId: weatherStation.id,
              ),
              gapH8,
              WeatherStationDetailsCharacteristics(
                weatherStation: weatherStation,
              ),
              gapH8,
              WeatherStationDetailsStatistics(
                weatherStationId: weatherStation.id,
              ),
              gapH48,
            ],
          ),
        ),
      ],
    );
  }
}
