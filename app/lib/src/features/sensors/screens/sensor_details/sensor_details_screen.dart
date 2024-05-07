import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sensors/data/sensor_repository.dart';
import 'package:irrigazione_iot/src/features/sensors/screens/sensor_details/sensor_details_screen_contents.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_placeholder_widget.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';

class SensorDetailsScreen extends ConsumerWidget {
  const SensorDetailsScreen({super.key, required this.sensorId});

  final String sensorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final sensor = ref.watch(sensorStreamProvider(sensorId));
    return Scaffold(
      body: AsyncValueSliverWidget(
        value: sensor,
        data: (data) {
          if (data == null) {
            return EmptyPlaceholderWidget(message: loc.notAvailable);
          }
          return SensorDetailsScreenContents(sensor: data);
        },
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
