import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/config/styles/app_styles.dart';
import 'package:irrigazione_iot/src/features/sensors/models/sensor.dart';
import 'package:irrigazione_iot/src/features/sensors/widgets/sensor_battery_level_indicator.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_info_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_tablet_responsive_center.dart';

class SensorListTileItem extends ConsumerWidget {
  const SensorListTileItem({
    super.key,
    required this.sensor,
    required this.isDeleting,
  });

  final Sensor sensor;
  final bool isDeleting;

  void _onTap(BuildContext context) => context.pushNamed(
        AppRoute.sensorDetails.name,
        pathParameters: PathParameters(id: sensor.id).toJson()
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonTabletResponsiveCenter(
      child: IgnorePointer(
        ignoring: isDeleting,
        child: InkWell(
          onTap: () => _onTap(context),
          child: ListTile(
            leading: CommonInfoIconButton(
              onPressed: () => _onTap(context),
            ),
            title: Text(sensor.name),
            trailing: SensorBatteryLevelIndicator(sensorId: sensor.id),
            subtitle: Text(
              sensor.eui,
              style: context.commonSubtitleStyle,
            ),
          ),
        ),
      ),
    );
  }
}