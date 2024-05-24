import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/dashboard/data/dashboard_repository.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/sector_switched_on.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/sectors/sector_switched_on_list_tile.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/dashboard_item_column.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/dashboard_items_listview.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_placeholder_widget.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

/// Display the sectors that are switched on
class SectorsSwitchedOnList extends ConsumerWidget {
  const SectorsSwitchedOnList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final sectorsSwitchedOn = ref.watch(sectorsSwitchedOnStreamProvider);
    return AsyncValueSliverWidget<List<SectorSwitchedOn>?>(
      value: sectorsSwitchedOn,
      data: (data) {
        if (data == null || data.isEmpty) {
          return DashboardItemColumn(
            title: loc.sectorsSwitchedOn,
            child: EmptyPlaceholderWidget(
              message: loc.noSectorsSwitchedOn,
            ),
          );
        }

        return DashboardItemColumn(
          title: loc.sectorsSwitchedOn,
          child: DashboardItemsListView<SectorSwitchedOn>(
            items: data,
            itemBuilder: (context, index) {
              final sectorSwitchedOn = data[index];
              return SectorSwitchedOnListTile(item: sectorSwitchedOn);
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
