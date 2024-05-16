import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/config/styles/app_styles.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station.dart';
import 'package:irrigazione_iot/src/features/weather_stations/widgets/weather_station_battery_level_indicator.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_info_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_tablet_responsive_center.dart';

class WeatherStationListTileItem extends StatelessWidget {
  const WeatherStationListTileItem({
    super.key,
    required this.weatherStation,
    required this.isDeleting,
  });

  final WeatherStation weatherStation;
  final bool isDeleting;

  void _onTap(BuildContext context) =>
      context.pushNamed(AppRoute.weatherStationDetails.name,
          pathParameters: PathParameters(id: weatherStation.id).toJson());

  @override
  Widget build(BuildContext context) {
    return CommonTabletResponsiveCenter(
      child: IgnorePointer(
        ignoring: isDeleting,
        child: InkWell(
          onTap: () => _onTap(context),
          child: ListTile(
            leading: CommonInfoIconButton(
              onPressed: () => _onTap(context),
            ),
            title: Text(weatherStation.name),
            trailing: WeatherStationBatteryLevelIndicator(
              weatherStationId: weatherStation.id,
            ),
            subtitle: Text(
              weatherStation.eui,
              style: context.commonSubtitleStyle,
            ),
          ),
        ),
      ),
    );
  }
}
