import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/empty_sector_widget.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/sector_list/dismiss_sector_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/sector_list/sector_list_tile.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/sector_switch_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/sector_list/sectors_list_tile_skeleton.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/user_companies_repository.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_bar_icon_buttons.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';

class SectorsListScreen extends ConsumerWidget {
  const SectorsListScreen({super.key});

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
    final canEdit = ref.watch(companyUserRoleProvider).valueOrNull?.canEdit;

    final sectors = ref.watch(sectorListStreamProvider);
    final isLoading = ref.watch(sectorSwitchControllerProvider).isLoading;
    final loc = context.loc;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: loc.sectorPageTitle,
            actions: [
              AppBarIconButton(
                isVisibile: canEdit,
                onPressed: isLoading
                    ? () {}
                    : () => context.goNamed(
                          AppRoute.addSector.name,
                        ), // activate button
                icon: Icons.add,
              )
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
    );
  }
}
