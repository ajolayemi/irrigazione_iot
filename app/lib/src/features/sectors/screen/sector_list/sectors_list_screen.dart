import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/routes_enums.dart';

import '../../data/sector_pump_repository.dart';
import '../../data/sector_repository.dart';
import '../empty_sector_widget.dart';
import 'dismiss_sector_controller.dart';
import 'sector_list_tile.dart';
import 'sectors_list_tile_skeleton.dart';
import '../sector_switch_controller.dart';
import '../../../../utils/async_value_ui.dart';
import '../../../../utils/extensions.dart';
import '../../../../widgets/app_sliver_bar.dart';
import '../../../../widgets/async_value_widget.dart';
import '../../../../widgets/common_add_icon_button.dart';

class SectorsListScreen extends ConsumerWidget {
  const SectorsListScreen({super.key});

  void _onAddSectorPressed(WidgetRef ref, BuildContext context) {
    ref.read(selectedPumpsIdProvider.notifier).state = [];
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
