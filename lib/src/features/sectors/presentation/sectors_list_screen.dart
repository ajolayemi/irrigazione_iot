import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/presentation/sector_list_tile.dart';
import 'package:irrigazione_iot/src/features/sectors/presentation/sectors_list_tile_skeleton.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/user_companies_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_bar_icon_buttons.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';

class SectorsListScreen extends ConsumerWidget {
  const SectorsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canEdit = ref.watch(companyUserRoleProvider).valueOrNull?.canEdit;
    final currentCompanyId =
        ref.watch(currentTappedCompanyProvider).valueOrNull?.id ?? '';
    final sectors = ref.watch(sectorListStreamProvider(currentCompanyId));
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: context.loc.sectorPageTitle,
            actions: [
              AppBarIconButton(
                isVisibile: canEdit,
                onPressed: () {}, // activate button
                icon: Icons.add,
              )
            ],
          ),

          // todo fix the loading state error - it shows for a second and then dis
          AsyncValueSliverWidget(
            value: sectors,
            data: (sectors) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final sector = sectors[index];
                    // todo return a widget to tell user that they don't have any sectors
                    if (sector == null) return const SliverToBoxAdapter();
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
