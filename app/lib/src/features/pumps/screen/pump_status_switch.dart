import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_status_switch_controller.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';

class PumpSwitch extends ConsumerWidget {
  const PumpSwitch({
    super.key,
    required this.pump,
  });

  final Pump pump;

  // * Keys for testing using find.byKey
  static Key pumpStatusSwitchKey(Pump pump) =>
      Key('pumpStatusSwitchKey_${pump.id}');

  Future<void> _toggleSwitch(
    BuildContext context,
    WidgetRef ref,
    bool status,
  ) async {
    final loc = context.loc;
    final update = await showAlertDialog(
      context: context,
      content: status
          ? loc.onStatusUpdateAlertDialogContent(pump.name)
          : loc.offStatusUpdateAlertDialogContent(pump.name),
      title: loc.genericAlertDialogTitle,
      cancelActionText: loc.alertDialogCancel,
      defaultActionText: status
          ? loc.onStatusDialogConfirmButtonTitle
          : loc.offStatusDialogConfirmButtonTitle,
    );

    if (update == null || update == false) return;

    ref
        .read(pumpStatusSwitchControllerProvider.notifier)
        .toggleStatus(pump, status);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thisPumpStatusIsLoading = ref
        .watch(pumpStatusSwitchControllerProvider)
        .stateWithIdIsLoading(pump.id);

    final globalLoadingState =
        ref.watch(pumpStatusSwitchControllerProvider).isGlobalLoading;
    final isSwitchedOn =
        ref.watch(pumpStatusStreamProvider(pump)).valueOrNull ?? false;

    return thisPumpStatusIsLoading
        ? const CircularProgressIndicator.adaptive()
        : Switch.adaptive(
            key: pumpStatusSwitchKey(pump),
            value: isSwitchedOn,
            onChanged: globalLoadingState
                ? null
                : (value) => _toggleSwitch(context, ref, value),
          );
  }
}
