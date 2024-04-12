import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/routes/routes_enums.dart';
import '../../../constants/breakpoints.dart';
import '../model/pump.dart';
import 'pump_list_tile_subtitle.dart';
import 'pump_status_switch_controller.dart';
import 'pump_status_switch.dart';
import 'dismiss_pump_controller.dart';
import '../../../utils/custom_controller_state.dart';
import '../../../utils/extensions.dart';
import '../../../widgets/alert_dialogs.dart';
import '../../../widgets/custom_dismissible.dart';
import '../../../widgets/responsive_center.dart';

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
        ref.watch(pumpStatusSwitchControllerProvider).isGlobalLoading;

    final isDeleting = ref.watch(dismissPumpControllerProvider).isLoading;

    // TODO: Remove switch
    // TODO: replace with normal Outlined Button
    // TODO: an indicator after pump name to indicate if on or off
    // TODO: info icon button to view details
    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      child: InkWell(
        onTap: globalLoadingState
            ? null
            : () => context.goNamed(
                  AppRoute.pumpDetails.name,
                  pathParameters: {
                    'pumpId': pump.id,
                  },
                ),
        child: CustomDismissibleWidget(
          dismissibleKey: pumpListTileKey(pump),
          confirmDismiss: (_) async => await _dismissPump(context, ref),
          onDismissed: (_) {},
          isDeleting: isDeleting,
          child: ListTile(
            title: Text(pump.name),
            subtitle: PumpListTileSubtitle(pump: pump),
            trailing: OutlinedButton(onPressed: () {}, child: Text('Spegni'))
          ),
        ),
      ),
    );
  }
}
