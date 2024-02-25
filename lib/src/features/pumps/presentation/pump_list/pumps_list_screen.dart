import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/pump_status/pum_status_tile_wid.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/pump_status/pump_status_switch_controller.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/app_bar_icon_buttons.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';

class PumpListScreen extends ConsumerWidget {
  const PumpListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      pumpStatusSwitchControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final companyPumps = ref.watch(companyPumpsStreamProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: context.loc.pumpPageTitle,
            actions: [
              AppBarIconButton(
                onPressed: () => showNotImplementedAlertDialog(
                  context: context,
                ), // todo add logic to add new pump
                icon: Icons.add,
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
                    title: pump.name,
                    onTap: () => context.goNamed(
                      AppRoute.pumpDetails.name,
                      pathParameters: {
                        'pumpId': pump.id,
                      },
                    ),
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
