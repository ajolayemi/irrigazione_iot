import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/sensors/data/sensor_repository.dart';
import 'package:irrigazione_iot/src/features/sensors/screens/sensor_list/dismiss_sensor_controller.dart';
import 'package:irrigazione_iot/src/features/sensors/widgets/sensor_list_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_sliver_list_skeleton.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_data_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

// Displays a list of sensors.
class SensorsListScreen extends ConsumerWidget {
  const SensorsListScreen({super.key});

  void _onTapAdd(BuildContext context) =>
      context.pushNamed(AppRoute.addSensor.name);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      dismissSensorControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final loc = context.loc;
    final sensors = ref.watch(sensorsStreamProvider);

    return Scaffold(
      body: PaddedSafeArea(
        child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: loc.sensorPageTitle,
              actions: [
                CommonAddIconButton(
                  onPressed: () => _onTapAdd(context),
                )
              ],
            ),
            AsyncValueSliverWidget(
              value: sensors,
              data: (data) {
                if (data == null || data.isEmpty) {
                  return SliverFillRemaining(
                    child: EmptyDataWidget(
                      message: loc.emptyDataPlaceholder(loc.nSensors(1)),
                      buttonText: loc.addNewButtonLabel,
                      onPressed: () => _onTapAdd(context),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final sensor = data[index];
                      return SensorListTile(sensor: sensor);
                    },
                    childCount: data.length,
                  ),
                );
              },
              loading: () => const CommonSliverListSkeleton(),
            )
          ],
        ),
      ),
    );
  }
}
