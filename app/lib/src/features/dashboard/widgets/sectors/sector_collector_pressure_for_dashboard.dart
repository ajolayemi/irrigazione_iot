import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/sectors/sector_collector_pressure_last_updated.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/common_pressure_rate_trailing_text.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/dashboard_child_item_details_row.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

/// Displays the current pressure of the [Collector] a sector belongs to.
class SectorCollectorPressureForDashboard extends ConsumerWidget {
  const SectorCollectorPressureForDashboard({
    super.key,
    required this.sectorId,
  });

  final String sectorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectorId =
        ref.watch(collectorIdBySectorIdStreamProvider(sectorId)).valueOrNull;

    if (collectorId == null) {
      return const SectorCollectorPressureForDashboardContent();
    }

    return Consumer(
      builder: (context, ref, child) {
        final pressure =
            ref.watch(collectorPressureStreamProvider(collectorId));
        final value = pressure.valueOrNull;
        final filterInPressure = value?.filterInPressure ?? 0.0;
        final filterOutPressure = value?.filterOutPressure ?? 0.0;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectorCollectorPressureLastUpdated(collectorId: collectorId),
            gapH8,
            SectorCollectorPressureForDashboardContent(
              filterInPressure: filterInPressure,
              filterOutPressure: filterOutPressure,
            ),
          ],
        );
      },
    );
  }
}

class SectorCollectorPressureForDashboardContent extends StatelessWidget {
  const SectorCollectorPressureForDashboardContent({
    super.key,
    this.filterInPressure,
    this.filterOutPressure,
  });

  final double? filterInPressure;
  final double? filterOutPressure;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardChildItemDetailsRow(
          leading: Text(loc.filterInForDashboard),
          trailing: CommonPressureRateTrailingText(
            pressure: filterInPressure ?? 0.0,
          ),
        ),
        gapH8,
        DashboardChildItemDetailsRow(
          leading: Text(loc.filterOutForDashboard),
          trailing: CommonPressureRateTrailingText(
            pressure: filterOutPressure ?? 0.0,
          ),
        ),
      ],
    );
  }
}
