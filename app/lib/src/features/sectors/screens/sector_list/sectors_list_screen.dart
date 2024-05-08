import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/empty_sector_widget.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_list/dismiss_sector_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sector_list_tile.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sectors_list_tile_skeleton.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_switch_controller.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class SectorsListScreen extends ConsumerWidget {
  const SectorsListScreen({super.key});

  void _onAddSectorPressed(WidgetRef ref, BuildContext context) {

    context.pushNamed(AppRoute.addSector.name);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      sectorSwitchControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    ref.listen(
      dismissSectorControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final sectors = ref.watch(sectorListStreamProvider);
    final isLoading = ref.watch(sectorSwitchControllerProvider).isLoading;
    final loc = context.loc;
    return Scaffold(
      body: SafeArea(
        child: IgnorePointer(
          ignoring: isLoading,
          child: CustomScrollView(
            slivers: [
              AppSliverBar(
                title: loc.sectorPageTitle,
                actions: [
                  CommonAddIconButton(
                    onPressed: () => _onAddSectorPressed(ref, context),
                  ),
                ],
              ),
              AsyncValueSliverWidget(
                value: sectors,
                data: (sectors) {
                  if (sectors.isEmpty) {
                    return const EmptySectorWidget();
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final sector = sectors[index];
                        if (sector == null) {
                          return const EmptySectorWidget();
                        }
                        return SectorListTile(sector: sector);
                      },
                      childCount: sectors.length,
                    ),
                  );
                },
                loading: () => const SectorsListTileSkeleton(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
