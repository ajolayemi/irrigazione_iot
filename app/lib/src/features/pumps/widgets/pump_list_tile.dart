import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/features/authentication/role_management/data/role_management_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/screens/pump_list/dismiss_pump_controller.dart';
import 'package:irrigazione_iot/src/features/pumps/screens/pump_list/pump_status_controller.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_list_tile_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_dismissible.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class PumpListTile extends ConsumerWidget {
  const PumpListTile({
    super.key,
    required this.pump,
  });

  final Pump pump;

  // Key for testing using find.byKey
  static Key pumpListTileKey(Pump pump) => Key('pumpStatusTileKey_${pump.id}');

  Future<bool> _dismissPump(BuildContext context, WidgetRef ref) async {
    final loc = context.loc;
    final askUser = await showAlertDialog(
          context: context,
          title: loc.genericAlertDialogTitle,
          content: loc.deleteConfirmationDialogTitle(
            loc.nPumpsWithArticulatedPreposition(1),
          ),
          defaultActionText: loc.alertDialogDelete,
          cancelActionText: loc.alertDialogCancel,
        ) ??
        false;
    if (!askUser) return false;

    return ref
        .read(dismissPumpControllerProvider.notifier)
        .confirmDismiss(pump.id);
  }



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalLoadingState =
        ref.watch(pumpStatusControllerProvider).isGlobalLoading;
    final isDeleting = ref.watch(dismissPumpControllerProvider).isLoading;
    final canDelete =
        ref.watch(userCanDeleteStreamProvider).valueOrNull ?? false;
    return CustomDismissibleWidget(
      canDelete: canDelete,
      dismissibleKey: pumpListTileKey(pump),
      confirmDismiss: (_) async => await _dismissPump(context, ref),
      onDismissed: (_) {},
      isDeleting: isDeleting,
      child: PumpListTileItem(
        pump: pump,
        isDeleting: isDeleting,
        stateIsLoading: globalLoadingState,
      ),
    );
  }
}
