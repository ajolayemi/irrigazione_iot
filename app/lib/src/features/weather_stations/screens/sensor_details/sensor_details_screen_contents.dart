import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/sensor.dart';
import 'package:irrigazione_iot/src/features/weather_stations/widgets/sensor_details_characteristics.dart';
import 'package:irrigazione_iot/src/features/weather_stations/widgets/sensor_details_last_update_card.dart';
import 'package:irrigazione_iot/src/features/weather_stations/widgets/sensor_details_statistics.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_edit_icon_button.dart';

class SensorDetailsScreenContents extends ConsumerWidget {
  const SensorDetailsScreenContents({super.key, required this.sensor});

  final Sensor sensor;

  void _onTapEdit(BuildContext context) {
    final param = PathParameters(id: sensor.id).toJson();

    context.pushNamed(
      AppRoute.updateSensor.name,
      pathParameters: param,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        AppSliverBar(
          title: sensor.name,
          actions: [
            CommonEditIconButton(
              onPressed: () => _onTapEdit(context),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              SensorDetailsLastUpdateCard(sensorId: sensor.id),
              gapH8,
              SensorDetailsCharacteristics(sensor: sensor),
              gapH8,
              SensorDetailsStatistics(sensorId: sensor.id),
              gapH48,
            ],
          ),
        ),
      ],
    );
  }
}
