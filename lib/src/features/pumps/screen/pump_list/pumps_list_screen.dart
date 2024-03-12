import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/empty_pump_widget.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_status/pump_status_tile_wid.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_status/pump_status_switch_controller.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_status/pump_status_tile_widget_skeleton.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/user_companies_repository.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
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
    final canEdit = ref.watch(companyUserRoleProvider).valueOrNull?.canEdit;

    final companyPumps = ref.watch(companyPumpsStreamProvider);

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: context.loc.pumpPageTitle,
              actions: [
                AppBarIconButton(
                  isVisibile: canEdit,
                  onPressed: () => context.pushNamed(
                    AppRoute.addPump.name,
                  ),
                  icon: Icons.add,
                )
              ],
            ),
            AsyncValueSliverWidget(
              value: companyPumps,
              loading: () => const PumpStatusTileSkeletonWidget(), // todo replace
              data: (pumps) {
                if (pumps.isEmpty) {
                  return const EmptyPumpWidget();
                }
                // It should be save to assume that the pumps are not null here
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final pump = pumps[index]!;
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
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
