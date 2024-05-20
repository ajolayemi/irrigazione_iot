import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/features/dashboard/data/dashboard_repository.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/pump_statuses_stat.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/dashboard_item_column.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/dashboard_items_listview.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/pumps/pumps_switched_on_list_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

/// Widget to display the list of pumps switched on in the dashboard if there
/// are any.
class PumpsSwitchedOnList extends ConsumerWidget {
  const PumpsSwitchedOnList({super.key});

 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final pumpsSwitchedOn = ref.watch(pumpsStatusesStatsStreamProvider);
    return AsyncValueSliverWidget<List<PumpStatusesStat>?>(
      value: pumpsSwitchedOn,
      data: (data) {
        if (data == null || data.isEmpty) {
          return Container();
        }

        return DashboardItemColumn(
          title: loc.pumpsSwitchedOn,
          child: DashboardItemsListView<PumpStatusesStat>(
            items: data,
            itemBuilder: (context, index) {
              final pump = data[index];
              return PumpSwitchedOnListTile(pumpStatusStat: pump);
            },
          ),
        );
      },
      loading: () => const CircularProgressIndicator.adaptive(),
    );
  }
}
