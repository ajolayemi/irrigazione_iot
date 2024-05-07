import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/sensors/data/sensor_measurement_repository.dart';
import 'package:irrigazione_iot/src/features/sensors/model/sensor_measurements_database_keys.dart';
import 'package:irrigazione_iot/src/features/sensors/widgets/sensor_details_statistic_tile.dart';
import 'package:irrigazione_iot/src/shared/models/history_query_params.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_expansion_tile.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';

class SensorDetailsStatistics extends ConsumerWidget {
  const SensorDetailsStatistics({super.key, required this.sensorId});

  final String sensorId;

  void _onTap(
    BuildContext context,
    String valueToLoad,
    String element
  ) {
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
        .watch(
          lastSensorMeasurementStreamProvider(sensorId),
        )
        .valueOrNull;
    return CommonExpansionTile(
      title: loc.entityStatistics,
      children: [
        SensorDetailsStatisticTile(
          title: loc.airTemperature,
          subtitle: lastSensorMeasurements?.airTemperature.toString() ,
          keyForUm: SensorMeasurementsDatabaseKeys.airTemperature ,
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.airTemperature,
            loc.airTemperature,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.airHumidity,
          subtitle:lastSensorMeasurements?.airHumidity.toString(),
          keyForUm: SensorMeasurementsDatabaseKeys.airHumidity,
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.airHumidity,
            loc.airHumidity,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.lightIntensity,
          subtitle: lastSensorMeasurements?.lightIntensity.toString(),
          keyForUm: SensorMeasurementsDatabaseKeys.lightIntensity,
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.lightIntensity,
            loc.lightIntensity,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.barometricPressure,
          subtitle: lastSensorMeasurements?.barometricPressure.toString(),
          keyForUm: SensorMeasurementsDatabaseKeys.barometricPressure,
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.barometricPressure,
            loc.barometricPressure,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.windDirection,
          subtitle: lastSensorMeasurements?.windDirection.toString(),
          keyForUm: SensorMeasurementsDatabaseKeys.windDirection,
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.windDirection,
            loc.windDirection,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.windSpeed,
          subtitle: lastSensorMeasurements?.windSpeed.toString(),
          keyForUm: SensorMeasurementsDatabaseKeys.windSpeed,
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.windSpeed,
            loc.windSpeed,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.rainfallHourly,
          subtitle: lastSensorMeasurements?.rainGauge.toString(),
          keyForUm: SensorMeasurementsDatabaseKeys.rainGauge,
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.rainGauge,
            loc.rainfallHourly,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.uvIndex,
          subtitle: lastSensorMeasurements?.uvIndex.toString(),
          keyForUm: SensorMeasurementsDatabaseKeys.uvIndex,
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.uvIndex,
            loc.uvIndex,
          ),
        )
      ],
    );
  }
}
