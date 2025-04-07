import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/dashboard_child_item_details_row.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

/// Displays the last time the pressure of the collector
///
/// a sector belongs to was updated.
///
class SectorCollectorPressureLastUpdated extends ConsumerWidget {
  const SectorCollectorPressureLastUpdated({
    super.key,
    required this.collectorId,
  });

  final String collectorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastCollectorPressureDate =
        ref.watch(collectorPressureStreamProvider(collectorId).select(
      (value) => value.valueOrNull?.createdAt,
    ));

    if (lastCollectorPressureDate == null) {
      return const SectorCollectorPressureLastUpdatedContent();
    }
    return Timeago(
      builder: (_, value) {
        return SectorCollectorPressureLastUpdatedContent(content: value);
      },
      date: lastCollectorPressureDate,
      locale: context.locale,
    );
  }
}

class SectorCollectorPressureLastUpdatedContent extends StatelessWidget {
  const SectorCollectorPressureLastUpdatedContent({super.key, this.content});

  final String? content;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return DashboardChildItemDetailsRow(
      leading: Text(loc.lastUpdated),
      trailing: Text(content ?? loc.notAvailable),
    );
  }
}
