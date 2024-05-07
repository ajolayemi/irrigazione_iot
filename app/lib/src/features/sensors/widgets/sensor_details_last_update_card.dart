import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sensors/data/sensor_measurement_repository.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';

class SensorDetailsLastUpdateCard extends ConsumerWidget {
  const SensorDetailsLastUpdateCard({super.key, required this.sensorId});

  final String sensorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final lastSensorMeasurement = ref.watch(
      lastSensorMeasurementStreamProvider(sensorId),
    );
    final value = lastSensorMeasurement.valueOrNull;
    final lastUpdated = context.customFormatDateTime(
      value?.createdAt,
      loc.notAvailable,
    );
    return ResponsiveDetailsCard(child: DetailTileWidget(
      title: loc.lastUpdated,
      subtitle: lastUpdated,
    ));
  }
}
