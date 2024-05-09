import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/authentication/role_management/data/role_management_repository.dart';
import 'package:irrigazione_iot/src/features/sensors/models/sensor.dart';
import 'package:irrigazione_iot/src/features/sensors/screens/sensor_list/dismiss_sensor_controller.dart';
import 'package:irrigazione_iot/src/features/sensors/widgets/sensor_list_tile_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_dismissible.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

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
    final canDelete =
        ref.watch(userCanDeleteStreamProvider).valueOrNull ?? false;

    return CustomDismissibleWidget(
      dismissibleKey: sensorListTileKey(sensor),
      canDelete: canDelete,
      isDeleting: isDeleting,
      confirmDismiss: (_) async => await _dismissSensor(context, ref),
      child: SensorListTileItem(
        sensor: sensor,
        isDeleting: isDeleting,
      ),
    );
  }
}
