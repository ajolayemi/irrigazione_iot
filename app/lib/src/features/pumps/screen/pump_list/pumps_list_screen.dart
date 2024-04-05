import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/enums/roles.dart';
import '../../../../config/routes/routes_enums.dart';
import '../../data/pump_repository.dart';
import '../empty_pump_widget.dart';
import '../pump_list_tile.dart';
import '../pump_status_switch_controller.dart';
import '../dismiss_pump_controller.dart';
import '../pump_list_tile_skeleton.dart';
import '../../../company_users/data/company_users_repository.dart';
import '../../../../utils/async_value_ui.dart';
import '../../../../utils/extensions.dart';
import '../../../../widgets/app_bar_icon_buttons.dart';
import '../../../../widgets/app_sliver_bar.dart';
import '../../../../widgets/async_value_widget.dart';
import '../../../../widgets/padded_safe_area.dart';

class PumpListScreen extends ConsumerWidget {
  const PumpListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      dismissPumpControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    ref.listen(
      pumpStatusSwitchControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final canEdit = ref.watch(companyUserRoleProvider).valueOrNull?.canEdit;

    final companyPumps = ref.watch(companyPumpsStreamProvider);

    return Scaffold(
      body: PaddedSafeArea(
        child: CustomScrollView(
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
              loading: () => const PumpListTileSkeleton(), // todo replace
              data: (pumps) {
                if (pumps.isEmpty) {
                  return const EmptyPumpWidget();
                }
                // It should be save to assume that the pumps are not null here
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final pump = pumps[index]!;
                      return PumpListTile(pump: pump);
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
