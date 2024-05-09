import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_details/sector_details_screen_content.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sectors_list_tile_skeleton.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_edit_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_placeholder_widget.dart';

class SectorDetailsScreen extends ConsumerWidget {
  const SectorDetailsScreen({
    super.key,
    required this.sectorID,
  });

  final String sectorID;

  void _onEditSector(BuildContext context) {
    final params = PathParameters(id: sectorID).toJson();
    context.pushNamed(AppRoute.updateSector.name, pathParameters: params);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: show sector pressure in the details screen (linea di aduzione)
    // TODO: add an icon to show how many sensors are connected to this sector
    final sectorData = ref.watch(sectorStreamProvider(sectorID));
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
                    CommonEditIconButton(
                        onPressed: () => _onEditSector(context))
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
