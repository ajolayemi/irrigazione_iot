import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/sensors/screen/add_update_sensor/add_update_sensor_controller.dart';
import 'package:irrigazione_iot/src/features/sensors/screen/add_update_sensor/add_update_sensor_form_contents.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';

class AddUpdateSensorForm extends ConsumerWidget {
  const AddUpdateSensorForm({
    super.key,
    required this.formType,
    this.sensorId,
  });

  final GenericFormTypes formType;
  final String? sensorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      addUpdateSensorControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final isLoading = ref.watch(addUpdateSensorControllerProvider).isLoading;
    return PopScope(
      canPop: !isLoading,
      onPopInvoked: (didPop) {
        if (didPop) {
          debugPrint('User exited the sensor form');
        } else {
          debugPrint('User tried to exit the sensor form');
        }
      },
      child: Scaffold(
        body: PaddedSafeArea(
          child: AddUpdateSensorFormContents(
            formType: formType,
            sensorId: sensorId,
          ),
        ),
      ),
    );
  }
}
