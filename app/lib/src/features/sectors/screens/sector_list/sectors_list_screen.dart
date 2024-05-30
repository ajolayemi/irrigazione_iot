import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/providers/sector_search_query_result.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_list/dismiss_sector_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_switch_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/empty_sector_widget.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sector_list_tile.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sectors_list_tile_skeleton.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_search_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/filtered_screen_item_renderer.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';
import 'package:irrigazione_iot/src/shared/widgets/search_text_field.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class SectorsListScreen extends ConsumerStatefulWidget {
  const SectorsListScreen({super.key});

  @override
  ConsumerState<SectorsListScreen> createState() => _SectorsListScreenState();
}

class _SectorsListScreenState extends ConsumerState<SectorsListScreen> {
  bool _isSearching = false;
  void _onAddSectorPressed() => context.pushNamed(AppRoute.addSector.name);

  void _onPressedSearchIcon() {
    if (_isSearching) {
      ref.read(sectorSearchQueryResultProvider.notifier).reset();
    }
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    ref.listen(
      sectorSwitchControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    ref.listen(
      dismissSectorControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    // A list of original list of sectors that belong to the company
    final companySectors = ref.watch(companySectorsFutureProvider).valueOrNull;

    final filteredSectors = ref.watch(sectorSearchQueryResultProvider);

    return Scaffold(
      body: PaddedSafeArea(
        child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: loc.sectorPageTitle,
              actions: [
                CommonSearchIconButton(
                  isVisibile: companySectors?.isNotEmpty ?? false,
                  onPressed: _onPressedSearchIcon,
                  isSearching: _isSearching,
                ),
                CommonAddIconButton(
                  onPressed: _onAddSectorPressed,
                ),
              ],
            ),
            if (_isSearching)
              SearchTextField(
                onSearch:
                    ref.read(sectorSearchQueryResultProvider.notifier).search,
              ),
            AsyncValueSliverWidget(
              value: filteredSectors,
              data: (filteredResult) {
                return FilteredScreenItemRenderer<Sector?>(
                    baseItems: companySectors,
                    filteredItems: filteredResult,
                    noBaseItemsWidget: const EmptySectorWidget(),
                    mainWidget: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final sector = filteredResult![index];

                          return SectorListTile(sector: sector);
                        },
                        childCount: filteredResult?.length,
                      ),
                    ));
              },
              loading: () => const SectorsListTileSkeleton(),
            )
          ],
        ),
      ),
    );
  }
}
