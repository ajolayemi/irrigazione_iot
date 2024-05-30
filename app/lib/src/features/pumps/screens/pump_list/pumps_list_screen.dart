import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/screens/pump_list/dismiss_pump_controller.dart';
import 'package:irrigazione_iot/src/features/pumps/providers/pump_search_query_result.dart';
import 'package:irrigazione_iot/src/features/pumps/screens/pump_list/pump_status_controller.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/empty_pump_widget.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_list_tile.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_list_tile_skeleton.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_search_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_search_result.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';
import 'package:irrigazione_iot/src/shared/widgets/search_text_field.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class PumpListScreen extends ConsumerStatefulWidget {
  const PumpListScreen({super.key});

  @override
  ConsumerState<PumpListScreen> createState() => _PumpListScreenState();
}

class _PumpListScreenState extends ConsumerState<PumpListScreen> {
  bool _showSearchField = false;

  /// Responds to the search query.
  void _onPressedSearchIcon() {
    if (_showSearchField) {
      ref.read(pumpSearchQueryResultProvider.notifier).reset();
    }
    setState(() {
      _showSearchField = !_showSearchField;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      dismissPumpControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    ref.listen(
      pumpStatusControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    /// A list of original list of pumps that belong to the company
    final companyPumps = ref.watch(companyPumpsFutureProvider).valueOrNull;

    /// A list of pumps that are filtered based on the search query
    final filteredPumps = ref.watch(pumpSearchQueryResultProvider);

    return Scaffold(
      body: PaddedSafeArea(
        child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: context.loc.pumpPageTitle,
              actions: [
                CommonSearchIconButton(
                  isVisibile: companyPumps?.isNotEmpty ?? false,
                  isSearching: _showSearchField,
                  onPressed: _onPressedSearchIcon,
                ),
                CommonAddIconButton(
                  onPressed: () => context.pushNamed(
                    AppRoute.addPump.name,
                  ),
                ),
              ],
            ),
            // List of filter chips goes here

            if (_showSearchField)
              SearchTextField(
                onSearch:
                    ref.read(pumpSearchQueryResultProvider.notifier).search,
              ),
            AsyncValueSliverWidget(
              value: filteredPumps,
              loading: () => const PumpListTileSkeleton(), // todo replace
              data: (filterResult) {
                final originallyHasPumps =
                    companyPumps != null && companyPumps.isNotEmpty;

                final filterIsEmpty = filterResult?.isEmpty ?? true;

                if (!originallyHasPumps) {
                  return const EmptyPumpWidget();
                }

                if (originallyHasPumps && filterIsEmpty) {
                  return const EmptySearchResult();
                }

                // It should be save to assume that the pumps are not null here
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final pump = filterResult![index];
                      return PumpListTile(pump: pump);
                    },
                    childCount: filterResult?.length,
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
