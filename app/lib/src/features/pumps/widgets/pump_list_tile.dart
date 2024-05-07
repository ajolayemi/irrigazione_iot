import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_list/dismiss_pump_controller.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_list_tile_subtitle.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_list/pump_status_controller.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_tile_title.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_tile_trailing_button.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_dismissible.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_center.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';

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

  void _onTap(BuildContext context) {
    final pathParams = PathParameters(
      id: pump.id,
    ).toJson();
    context.goNamed(
      AppRoute.pumpDetails.name,
      pathParameters: pathParams,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalLoadingState =
        ref.watch(pumpStatusControllerProvider).isGlobalLoading;
    final isDeleting = ref.watch(dismissPumpControllerProvider).isLoading;

    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      child: InkWell(
        onTap: globalLoadingState ? null : () => _onTap(context),
        child: CustomDismissibleWidget(
          dismissibleKey: pumpListTileKey(pump),
          confirmDismiss: (_) async => await _dismissPump(context, ref),
          onDismissed: (_) {},
          isDeleting: isDeleting,
          child: ListTile(
            title: PumpTileTitle(pump: pump),
            subtitle: PumpListTileSubtitle(pump: pump),
            trailing: PumpTileTrailingButton(pump: pump),
          ),
        ),
      ),
    );
  }
}
