import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sensors/data/sensor_measurement_repository.dart';
import 'package:irrigazione_iot/src/features/sensors/model/sensor_measurements_database_keys.dart';
import 'package:irrigazione_iot/src/features/sensors/widgets/sensor_details_statistic_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_expansion_tile.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class SensorDetailsStatistics extends ConsumerWidget {
  const SensorDetailsStatistics({super.key, required this.sensorId});

  final String sensorId;

  void _onTap(BuildContext context, String valueToLoad) {
    print('tapped to get $valueToLoad');
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
          subtitle: '${lastSensorMeasurements?.airTemperature ?? 0} °C',
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.airTemperature,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.airHumidity,
          subtitle: '${lastSensorMeasurements?.airHumidity ?? 0} % RH',
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.airHumidity,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.lightIntensity,
          subtitle: '${lastSensorMeasurements?.lightIntensity ?? 0} Lux',
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.lightIntensity,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.barometricPressure,
          subtitle: '${lastSensorMeasurements?.barometricPressure ?? 0} Pa',
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.barometricPressure,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.windDirection,
          subtitle: '${lastSensorMeasurements?.windDirection ?? 0} °',
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.windDirection,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.windSpeed,
          subtitle: '${lastSensorMeasurements?.windSpeed ?? 0} m/s',
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.windSpeed,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.rainfallHourly,
          subtitle: '${lastSensorMeasurements?.rainGauge ?? 0} mm/h',
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.rainGauge,
          ),
        ),
        SensorDetailsStatisticTile(
          title: loc.uvIndex,
          subtitle: '${lastSensorMeasurements?.uvIndex ?? 0}',
          onTap: () => _onTap(
            context,
            SensorMeasurementsDatabaseKeys.uvIndex,
          ),
        )
      ],
    );
  }
}
