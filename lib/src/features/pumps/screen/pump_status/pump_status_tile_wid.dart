import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_status/pump_status_switch_controller.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_status/pump_status_switch.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_status/pump_status_tile_wid_controller.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/date_formatter.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

class PumpStatusTileWidget extends ConsumerWidget {
  const PumpStatusTileWidget({
    super.key,
    required this.pump,
    this.title,
    this.onTap,
  });

  final Pump pump;
  final String? title;
  final VoidCallback? onTap;

  // Key for testing using find.byKey
  static Key pumpStatusTileKey(Pump pump) =>
      Key('pumpStatusTileKey_${pump.id}');

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
        .read(pumpStatusTileWidgetControllerProvider.notifier)
        .confirmDismiss(pump.id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // todo - fix the ui issue when an error occurs and the
    // todo alert dialog doesn't dismiss immediately after first tap


    final dateFormatter = ref.watch(dateFormatWithTimeProvider);
    final lastDispensationDate =
        ref.watch(lastDispensationStreamProvider(pump.id)).valueOrNull;

    final aPumpIsCurrentlyLoading = ref.watch(
        pumpStatusSwitchControllerProvider.select(
            (state) => (state.value?.isLoading ?? false) && !state.hasError));

    final isDeleting =
        ref.watch(pumpStatusTileWidgetControllerProvider).isLoading;

    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      child: InkWell(
        onTap: aPumpIsCurrentlyLoading ? null : onTap,
        child: Dismissible(
          key: ValueKey(pumpStatusTileKey(pump)),
          direction: DismissDirection.endToStart,
          confirmDismiss: (_) async => await _dismissPump(context, ref),
          onDismissed: (_) {},
          background: Container(
            color: Colors.red,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 20.0),
            child: isDeleting
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
          ),
          child: ListTile(
            title: Text(title ?? ''),
            subtitleTextStyle:
                context.textTheme.titleSmall?.copyWith(color: Colors.grey),
            subtitle: Text(
              context.loc.pumpStatusLastSwitchedOn(
                lastDispensationDate == null
                    ? context.loc.notAvailable
                    : dateFormatter.format(lastDispensationDate),
              ),
            ),
            trailing: PumpSwitch(
              pump: pump,
            ),
          ),
        ),
      ),
    );
  }
}
