import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/dashboard_child_item_details_row.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

/// Displays the name of the [Collector] that is connected to a
///
/// particular [Sector] indicated by the provided [sectorId]
class SectorCollectorForDashboard extends ConsumerWidget {
  const SectorCollectorForDashboard({super.key, required this.sectorId});

  final String sectorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectorId =
        ref.watch(collectorIdBySectorIdStreamProvider(sectorId)).valueOrNull;

    if (collectorId == null) return const SectorCollectorForDashboardContent();
    return Consumer(
      builder: (context, ref, child) {
        final collectorName = ref.watch(
          collectorStreamProvider(collectorId)
              .select((collector) => collector.valueOrNull?.name),
        );
        return SectorCollectorForDashboardContent(
          collectorName: collectorName,
        );
      },
    );
  }
}

class SectorCollectorForDashboardContent extends StatelessWidget {
  const SectorCollectorForDashboardContent({
    super.key,
    this.collectorName,
  });

  final String? collectorName;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return DashboardChildItemDetailsRow(
      leading: Text(loc.nCollectors(1).capitalize),
      trailing: Text(collectorName ?? loc.notAvailable),
    );
  }
}
