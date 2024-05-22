import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/sector_switched_on.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/sectors/sector_collector_for_dashboard.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/sectors/sector_collector_pressure_for_dashboard.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/sectors/sector_dashboard_tile_title.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/sectors/sector_irrigation_duration.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/sectors/sector_pressure_for_dashboard.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/dashboard_child_item_list_tile.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/terminal/terminal_pressure_for_dashboard.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_responsive_divider.dart';

class SectorSwitchedOnListTile extends ConsumerWidget {
  const SectorSwitchedOnListTile({super.key, required this.item});

  final SectorSwitchedOn item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sector = ref.watch(sectorStreamProvider(item.sectorId)).valueOrNull;

    if (sector == null) return Container();

    return DashboardChildItemListTile(
      title: SectorDashboardTileTitle(sector: sector),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH8,
          SectorCollectorForDashboard(sectorId: sector.id),
          const CommonResponsiveDivider(),
          SectorCollectorPressureForDashboard(sectorId: sector.id),
          gapH8,
          SectorPressureForDashboard(sectorId: sector.id),
          gapH8,
          TerminalPressureForDashboard(sectorId: sector.id),
          const CommonResponsiveDivider(),
          SectorIrrigationDuration(sectorId: sector.id),
        ],
      ),
    );
  }
}
