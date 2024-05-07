import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/sensors/model/sensor.dart';
import 'package:irrigazione_iot/src/features/sensors/screen/sensor_list/dismiss_sensor_controller.dart';
import 'package:irrigazione_iot/src/features/sensors/widgets/sensor_list_tile_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_dismissible.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';

/// A list tile that displays sensor's basic information.
class SensorListTile extends ConsumerWidget {
  const SensorListTile({
    super.key,
    required this.sensor,
  });

  final Sensor sensor;

  static Key sensorListTileKey(Sensor sensor) =>
      Key('sensorListTileKey_${sensor.id}');

  Future<bool> _dismissSensor(BuildContext context, WidgetRef ref) async {
    final where = context.loc.nSensorsWithArticulatedPreposition(1);
    if (await context.showDismissalDialog(where: where)) {
      return await ref
          .read(dismissSensorControllerProvider.notifier)
          .confirmDismiss(sensor.id);
    }
    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeleting = ref.watch(dismissSensorControllerProvider).isLoading;
    // TODO: whether user can delete or not should be based (in the first version)
    // TODO on whether they're superuser or not. This will be changed in the future.
    // TODO: replace the line below to reflect that
    final userCanDelete =
        ref.watch(companyUserRoleProvider).valueOrNull?.canEdit ?? false;

    if (userCanDelete) {
      return CustomDismissibleWidget(
        dismissibleKey: sensorListTileKey(sensor),
        isDeleting: isDeleting,
        confirmDismiss: (_) async => await _dismissSensor(context, ref),
        child: SensorListTileItem(
          sensor: sensor,
          isDeleting: isDeleting,
        ),
      );
    }
    return SensorListTileItem(
      sensor: sensor,
      isDeleting: isDeleting,
    );
  }
}
