import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_measurement_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_measurements_database_keys.dart';
import 'package:irrigazione_iot/src/features/weather_stations/widgets/sensor_details_statistic_tile.dart';
import 'package:irrigazione_iot/src/shared/models/history_query_params.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_expansion_tile.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class SensorDetailsStatistics extends ConsumerWidget {
  const SensorDetailsStatistics({super.key, required this.sensorId});

  final String sensorId;

  void _onTap(BuildContext context, String valueToLoad, String element) {
    final queryParams = HistoryQueryParameters(
      columnName: valueToLoad,
      statisticName: element,
    ).toJson();
    context.pushNamed(
      AppRoute.sensorStatisticHistory.name,
      queryParameters: queryParams,
      pathParameters: PathParameters(id: sensorId).toJson(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final lastSensorMeasurements = ref
        .watch(lastWeatherStationMeasurementStreamProvider(sensorId))
        .valueOrNull;
    return CommonExpansionTile(
      title: loc.entityStatistics,
      children: [
        SensorDetailsStatisticTile(
          title: loc.airTemperature,
          subtitle: lastSensorMeasurements?.airTemperature.toString(),
          keyForUm: WeatherStationMeasurementsDatabaseKeys.airTemperature,
          onTap: () => _onTap(
            context,
            WeatherStationMeasurementsDatabaseKeys.airTemperature,
            loc.airTemperature,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.airHumidity,
          subtitle: lastSensorMeasurements?.airHumidity.toString(),
          keyForUm: WeatherStationMeasurementsDatabaseKeys.airHumidity,
          onTap: () => _onTap(
            context,
            WeatherStationMeasurementsDatabaseKeys.airHumidity,
            loc.airHumidity,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.lightIntensity,
          subtitle: lastSensorMeasurements?.lightIntensity.toString(),
          keyForUm: WeatherStationMeasurementsDatabaseKeys.lightIntensity,
          onTap: () => _onTap(
            context,
            WeatherStationMeasurementsDatabaseKeys.lightIntensity,
            loc.lightIntensity,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.barometricPressure,
          subtitle: lastSensorMeasurements?.barometricPressure.toString(),
          keyForUm: WeatherStationMeasurementsDatabaseKeys.barometricPressure,
          onTap: () => _onTap(
            context,
            WeatherStationMeasurementsDatabaseKeys.barometricPressure,
            loc.barometricPressure,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.windDirection,
          subtitle: lastSensorMeasurements?.windDirection.toString(),
          keyForUm: WeatherStationMeasurementsDatabaseKeys.windDirection,
          onTap: () => _onTap(
            context,
            WeatherStationMeasurementsDatabaseKeys.windDirection,
            loc.windDirection,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.windSpeed,
          subtitle: lastSensorMeasurements?.windSpeed.toString(),
          keyForUm: WeatherStationMeasurementsDatabaseKeys.windSpeed,
          onTap: () => _onTap(
            context,
            WeatherStationMeasurementsDatabaseKeys.windSpeed,
            loc.windSpeed,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.rainfallHourly,
          subtitle: lastSensorMeasurements?.rainGauge.toString(),
          keyForUm: WeatherStationMeasurementsDatabaseKeys.rainGauge,
          onTap: () => _onTap(
            context,
            WeatherStationMeasurementsDatabaseKeys.rainGauge,
            loc.rainfallHourly,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.uvIndex,
          subtitle: lastSensorMeasurements?.uvIndex.toString(),
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
