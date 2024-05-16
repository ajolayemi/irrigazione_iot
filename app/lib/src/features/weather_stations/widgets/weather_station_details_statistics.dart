import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_measurement_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_measurements_database_keys.dart';
import 'package:irrigazione_iot/src/features/weather_stations/widgets/weather_station_details_statistic_tile.dart';
import 'package:irrigazione_iot/src/shared/models/history_query_params.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_expansion_tile.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class WeatherStationDetailsStatistics extends ConsumerWidget {
  const WeatherStationDetailsStatistics({
    super.key,
    required this.weatherStationId,
  });

  final String weatherStationId;

  void _onTap(BuildContext context, String valueToLoad, String element) {
    final queryParams = HistoryQueryParameters(
      columnName: valueToLoad,
      statisticName: element,
    ).toJson();
    context.pushNamed(
      AppRoute.weatherStationStatisticHistory.name,
      queryParameters: queryParams,
      pathParameters: PathParameters(id: weatherStationId).toJson(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final lastMeasurements = ref
        .watch(lastWeatherStationMeasurementStreamProvider(weatherStationId))
        .valueOrNull;
    return CommonExpansionTile(
      title: loc.entityStatistics,
      children: [
        WeatherStationDetailsStatisticTile(
          title: loc.airTemperature,
          subtitle: lastMeasurements?.airTemperature.toString(),
          keyForUm: WeatherStationMeasurementsDatabaseKeys.airTemperature,
          onTap: () => _onTap(
            context,
            WeatherStationMeasurementsDatabaseKeys.airTemperature,
            loc.airTemperature,
          ),
        ),
        WeatherStationDetailsStatisticTile(
          title: loc.airHumidity,
          subtitle: lastMeasurements?.airHumidity.toString(),
          keyForUm: WeatherStationMeasurementsDatabaseKeys.airHumidity,
          onTap: () => _onTap(
            context,
            WeatherStationMeasurementsDatabaseKeys.airHumidity,
            loc.airHumidity,
          ),
        ),
        WeatherStationDetailsStatisticTile(
          title: loc.lightIntensity,
          subtitle: lastMeasurements?.lightIntensity.toString(),
          keyForUm: WeatherStationMeasurementsDatabaseKeys.lightIntensity,
          onTap: () => _onTap(
            context,
            WeatherStationMeasurementsDatabaseKeys.lightIntensity,
            loc.lightIntensity,
          ),
        ),
        WeatherStationDetailsStatisticTile(
          title: loc.barometricPressure,
          subtitle: lastMeasurements?.barometricPressure.toString(),
          keyForUm: WeatherStationMeasurementsDatabaseKeys.barometricPressure,
          onTap: () => _onTap(
            context,
            WeatherStationMeasurementsDatabaseKeys.barometricPressure,
            loc.barometricPressure,
          ),
        ),
        WeatherStationDetailsStatisticTile(
          title: loc.windDirection,
          subtitle: lastMeasurements?.windDirection.toString(),
          keyForUm: WeatherStationMeasurementsDatabaseKeys.windDirection,
          onTap: () => _onTap(
            context,
            WeatherStationMeasurementsDatabaseKeys.windDirection,
            loc.windDirection,
          ),
        ),
        WeatherStationDetailsStatisticTile(
          title: loc.windSpeed,
          subtitle: lastMeasurements?.windSpeed.toString(),
          keyForUm: WeatherStationMeasurementsDatabaseKeys.windSpeed,
          onTap: () => _onTap(
            context,
            WeatherStationMeasurementsDatabaseKeys.windSpeed,
            loc.windSpeed,
          ),
        ),
        WeatherStationDetailsStatisticTile(
          title: loc.rainfallHourly,
          subtitle: lastMeasurements?.rainGauge.toString(),
          keyForUm: WeatherStationMeasurementsDatabaseKeys.rainGauge,
          onTap: () => _onTap(
            context,
            WeatherStationMeasurementsDatabaseKeys.rainGauge,
            loc.rainfallHourly,
          ),
        ),
        WeatherStationDetailsStatisticTile(
          title: loc.uvIndex,
          subtitle: lastMeasurements?.uvIndex.toString(),
          keyForUm: WeatherStationMeasurementsDatabaseKeys.uvIndex,
          onTap: () => _onTap(
            context,
            WeatherStationMeasurementsDatabaseKeys.uvIndex,
            loc.uvIndex,
          ),
        )
      ],
    );
  }
}
