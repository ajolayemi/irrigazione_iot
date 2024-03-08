import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/sector_switch_controller.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';

class SectorSwitch extends ConsumerWidget {
  const SectorSwitch({
    super.key,
    required this.sector,
  });

  final Sector sector;

  // * Keys for testing using find.byKey
  static Key sectorStatusSwitchKey(Sector sector) =>
      Key('sectorStatusSwitchKey_${sector.id}');

  Future<void> _toggleSwitch(
    BuildContext context,
    WidgetRef ref,
    bool status,
  ) async {
    final canContinue = await showAlertDialog(
      context: context,
      title: context.loc.genericAlertDialogTitle,
      content: status
          ? context.loc.onStatusUpdateAlertDialogContent(sector.name)
          : context.loc.offStatusUpdateAlertDialogContent(sector.name),
      defaultActionText: status
          ? context.loc.onStatusDialogConfirmButtonTitle
          : context.loc.offStatusDialogConfirmButtonTitle,
      cancelActionText: context.loc.alertDialogCancel,
    );

    if (canContinue == null || !canContinue) return;

    ref
        .read(sectorSwitchControllerProvider.notifier)
        .toggleStatus(sector, status);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thisSectorStatusIsLoading = ref
        .watch(sectorSwitchControllerProvider)
        .stateWithIdIsLoading(sector.id);

    final globalLoadingState =
        ref.watch(sectorSwitchControllerProvider).isGlobalLoading;

    final isSwitchedOn =
        ref.watch(sectorStatusStreamProvider(sector)).valueOrNull ?? false;

    return thisSectorStatusIsLoading
        ? const CircularProgressIndicator.adaptive()
        : Switch.adaptive(
            key: sectorStatusSwitchKey(sector),
            value: isSwitchedOn,
            onChanged: globalLoadingState
                ? null
                : (status) => _toggleSwitch(context, ref, status),
          );
  }
}
