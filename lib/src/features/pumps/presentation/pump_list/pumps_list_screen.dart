import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump_status.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/pump_list/pump_status_switch_controller.dart';
import 'package:irrigazione_iot/src/features/user_companies/application/user_companies_service.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

class PumpListScreen extends ConsumerWidget {
  const PumpListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      pumpStatusSwitchControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final currentSelectedCompanyByUser =
        ref.watch(currentTappedCompanyProvider).value;
    final companyPumps = ref.watch(companyPumpsStreamProvider(
      currentSelectedCompanyByUser?.id ?? '',
    ));
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: context.loc.pumpPageTitle,
            actions: [
              IconButton.filled(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
              )
            ],
          ),
          AsyncValueSliverWidget(
            value: companyPumps,
            data: (pumps) => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final pump = pumps[index];
                  return PumpStatusTileWidget(
                    pump: pump,
                  );
                },
                childCount: pumps.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PumpStatusTileWidget extends ConsumerWidget {
  const PumpStatusTileWidget({
    super.key,
    required this.pump,
  });

  final Pump pump;

  // Key for testing using find.byKey
  static Key pumpStatusTileKey(Pump pump) =>
      Key('pumpStatusTileKey_${pump.id}');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pumpStatus = ref.watch(pumpStatusStreamProvider(pump.id)).value;
    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      child: InkWell(
        onTap: () {
          // todo navigate to pump details
        },
        child: ListTile(
          title: Text(pump.name),
          subtitleTextStyle:
              context.textTheme.titleSmall?.copyWith(color: Colors.grey),
          subtitle: Text(
            context.loc.pumpStatusLastUpdate(
              pumpStatus?.lastUpdated ?? DateTime.now(),
              pumpStatus?.lastUpdated ?? DateTime.now(),
            ),
          ),
          trailing: PumpStatusSwitchWidget(pump: pump, pumpStatus: pumpStatus),
        ),
      ),
    );
  }
}

class PumpStatusSwitchWidget extends ConsumerWidget {
  const PumpStatusSwitchWidget(
      {super.key, required this.pump, this.pumpStatus});

  final Pump pump;
  final PumpStatus? pumpStatus;

  // * Keys for testing using find.byKey
  static Key pumpStatusSwitchKey(Pump pump) =>
      Key('pumpStatusSwitchKey_${pump.id}');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pumpStatusSwitchControllerProvider);
    final valueForSwitch = pumpStatus?.translateStatusToBoolean(
      pump,
      pumpStatus?.status ?? '',
    );
    return state.isLoading
        ? const CircularProgressIndicator.adaptive()
        : Switch.adaptive(
            key: pumpStatusSwitchKey(pump),
            value: valueForSwitch ?? false,
            onChanged: state.isLoading
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
