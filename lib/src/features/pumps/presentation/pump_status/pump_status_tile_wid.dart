import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/pump_status/pump_status_switch_controller.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/pump_status/pump_status_switch_widget.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/pump_status/pump_status_tile_wid_controller.dart';
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
    final askUser = await showAlertDialog(
          context: context,
          title: context.loc.genericAlertDialogTitle,
          content: context.loc.deletePumpConfirmationDialogTitle(pump.name),
          defaultActionText: context.loc.alertDialogDelete,
          cancelActionText: context.loc.alertDialogCancel,
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
    
    ref.listen(
      pumpStatusTileWidgetControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final dateFormatter = ref.watch(dateFormatWithTimeProvider);
    final lastDispensationDate =
        ref.watch(lastDispensationStreamProvider(pump.id)).valueOrNull;
    final pumpStatus = ref.watch(pumpStatusStreamProvider(pump.id)).valueOrNull;

    final aPumpIsCurrentlyLoading = ref.watch(
        pumpStatusSwitchControllerProvider.select(
            (state) => (state.value?.isLoading ?? false) && !state.hasError));

    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      child: InkWell(
        onTap: aPumpIsCurrentlyLoading ? null : onTap,
        child: Dismissible(
          key: pumpStatusTileKey(pump),
          direction: DismissDirection.endToStart,
          confirmDismiss: (_) => _dismissPump(context, ref),
          background: Container(
            color: Colors.red,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 20.0),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) {},
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
            trailing: PumpStatusSwitchWidget(
              pump: pump,
              pumpStatus: pumpStatus,
            ),
          ),
        ),
      ),
    );
  }
}
