import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/features/dashboard/data/dashboard_repository.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/pump_switched_on.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/dashboard_item_column.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/dashboard_items_listview.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/pumps/pumps_switched_on_list_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_placeholder_widget.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

/// Widget to display the list of pumps switched on in the dashboard if there
/// are any.
class PumpsSwitchedOnList extends ConsumerWidget {
  const PumpsSwitchedOnList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final pumpsSwitchedOn = ref.watch(pumpsSwitchedOnStreamProvider);
    return AsyncValueSliverWidget<List<PumpSwitchedOn>?>(
      value: pumpsSwitchedOn,
      data: (data) {
        if (data == null || data.isEmpty) {
          return DashboardItemColumn(
            title: loc.pumpsSwitchedOn,
            child: EmptyPlaceholderWidget(
              message: loc.noPumpsSwitchedOn,
            ),
          );
        }

        return DashboardItemColumn(
          title: loc.pumpsSwitchedOn,
          child: DashboardItemsListView<PumpSwitchedOn>(
            items: data,
            itemBuilder: (context, index) {
              final pumpSwitchedOn = data[index];
              return PumpSwitchedOnListTile(
                pumpSwitchedOn: pumpSwitchedOn,
              );
            },
          ),
        );
      },
      loading: () => const CircularProgressIndicator.adaptive(),
    );
  }
}
