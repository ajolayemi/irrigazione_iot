import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/enums/roles.dart';
import '../../../../config/routes/routes_enums.dart';
import '../../data/sector_pump_repository.dart';
import '../../data/sector_repository.dart';
import '../../model/sector.dart';
import '../../model/sector_pump.dart';
import 'sector_details_screen_content.dart';
import '../sector_list/sectors_list_tile_skeleton.dart';
import '../../../company_users/data/company_users_repository.dart';
import '../../../../widgets/app_bar_icon_buttons.dart';
import '../../../../widgets/app_sliver_bar.dart';
import '../../../../widgets/async_value_widget.dart';
import '../../../../widgets/empty_placeholder_widget.dart';

class SectorDetailsScreen extends ConsumerWidget {
  const SectorDetailsScreen({
    super.key,
    required this.sectorID,
  });

  final SectorID sectorID;

  void _onEditSector(WidgetRef ref, BuildContext context,
      List<SectorPump?>? connectedPumpsIds) {
    final pumpIds = connectedPumpsIds?.map((pump) => pump?.pumpId).toList();
    ref.read(selectedPumpsIdProvider.notifier).state = pumpIds ?? [];
    context.pushNamed(
      AppRoute.updateSector.name,
      pathParameters: {
        'sectorId': sectorID,
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: show sector pressure in the details screen (linea di aduzione)
    // TODO: add an icon to show how many sensors are connected to this sector
    final canEdit = ref.watch(companyUserRoleProvider).valueOrNull?.canEdit;
    final sectorData = ref.watch(sectorStreamProvider(sectorID));
    final sectorConnectedPumps =
        ref.watch(sectorPumpsStreamProvider(sectorID)).valueOrNull;
    return SafeArea(
      child: Scaffold(
        body: AsyncValueSliverWidget(
          value: sectorData,
          data: (sector) {
            if (sector == null) {
              return const EmptyPlaceholderWidget(message: 'aaaa');
            } // todo replace widget with the right one

            return CustomScrollView(
              slivers: [
                AppSliverBar(
                  title: sector.name,
                  actions: [
                    AppBarIconButton(
                      onPressed: () =>
                          _onEditSector(ref, context, sectorConnectedPumps),
                      icon: Icons.edit,
                      isVisibile: canEdit,
                    )
                  ],
                ),
                SectorDetailsScreenContents(
                  sector: sector,
                )
              ],
            );
          },
          loading: () => const SectorsListTileSkeletonNonSliver(),
        ),
      ),
    );
  }
}
