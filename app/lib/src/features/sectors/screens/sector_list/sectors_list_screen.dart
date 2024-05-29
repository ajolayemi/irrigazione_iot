import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_list/dismiss_sector_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_list/sector_search_query_result.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_switch_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/empty_sector_widget.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sector_list_tile.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sectors_list_tile_skeleton.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_search_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_search_result.dart';
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
      ref.read(sectorSearchQueryResultProvider.notifier).resetState();
    }
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      sectorSwitchControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    ref.listen(
      dismissSectorControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final sectors = ref.watch(sectorListStreamProvider);
    final loc = context.loc;

    final queryResult = ref.watch(sectorSearchQueryResultProvider);

    print(sectors.valueOrNull?.isNotEmpty);

    return Scaffold(
      body: PaddedSafeArea(
        child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: loc.sectorPageTitle,
              actions: [
                CommonSearchIconButton(
                  isVisibile: sectors.valueOrNull?.isNotEmpty ?? false,
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
              value: sectors,
              data: (data) {
                if (data.isNotEmpty && queryResult.isEmpty) {
                  return const EmptySearchResult();
                }
                if (data.isEmpty) {
                  return const EmptySectorWidget();
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final sector = queryResult[index];
                      if (sector == null) {
                        return const EmptySectorWidget();
                      }
                      return SectorListTile(sector: sector);
                    },
                    childCount: queryResult.length,
                  ),
                );
              },
              loading: () => const SectorsListTileSkeleton(),
            )
          ],
        ),
      ),
    );
  }
}
