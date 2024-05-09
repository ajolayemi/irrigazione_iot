import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/screens/pump_list/dismiss_pump_controller.dart';
import 'package:irrigazione_iot/src/features/pumps/screens/pump_list/pump_status_controller.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/empty_pump_widget.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_list_tile.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_list_tile_skeleton.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class PumpListScreen extends ConsumerWidget {
  const PumpListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      dismissPumpControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    ref.listen(
      pumpStatusControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final companyPumps = ref.watch(companyPumpsStreamProvider);

    return Scaffold(
      body: PaddedSafeArea(
        child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: context.loc.pumpPageTitle,
              actions: [
                CommonAddIconButton(
                  onPressed: () => context.pushNamed(
                    AppRoute.addPump.name,
                  ),
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
