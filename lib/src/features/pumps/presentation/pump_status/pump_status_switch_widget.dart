import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump_status.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/pump_status/pump_status_switch_controller.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';

class PumpStatusSwitchWidget extends ConsumerWidget {
  const PumpStatusSwitchWidget({
    super.key,
    required this.pump,
    this.pumpStatus,
  });

  final Pump pump;
  final PumpStatus? pumpStatus;

  // * Keys for testing using find.byKey
  static Key pumpStatusSwitchKey(Pump pump) =>
      Key('pumpStatusSwitchKey_${pump.id}');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(pumpStatusSwitchControllerProvider.select(
        (state) =>
            (state.value?.stateWithIdIsLoading(pump.id) ?? false) &&
            !state.hasError));

    final aPumpIsCurrentlyLoading = ref.watch(
        pumpStatusSwitchControllerProvider.select(
            (state) => (state.value?.isLoading ?? false) && !state.hasError));
    final valueForSwitch = pumpStatus?.translateStatusToBoolean(
      pump,
      pumpStatus?.status ?? '',
    );
    return loading
        ? const CircularProgressIndicator.adaptive()
        : Switch.adaptive(
            key: pumpStatusSwitchKey(pump),
            value: valueForSwitch ?? false,
            onChanged: aPumpIsCurrentlyLoading
                ? null
                : (value) async {
                    final update = await showAlertDialog(
                      context: context,
                      content: value
                          ? context.loc
                              .pumpOnStatusUpdateAlertDialogContent(pump.name)
                          : context.loc
                              .pumpOffStatusUpdateAlertDialogContent(pump.name),
                      title: context.loc.genericAlertDialogTitle,
                      cancelActionText: context.loc.alertDialogCancel,
                      defaultActionText: value
                          ? context.loc.pumpOnStatusDialogConfirmButtonTitle
                          : context.loc.pumpOffStatusDialogConfirmButtonTitle,
                    );
                    if (update == true) {
                      ref
                          .read(pumpStatusSwitchControllerProvider.notifier)
                          .toggleStatus(pump, value);
                    }
                  },
          );
  }
}
