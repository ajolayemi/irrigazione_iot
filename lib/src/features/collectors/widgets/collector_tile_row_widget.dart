import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/battery_level_indicator.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/sectors_switched_on_badge.dart';

class CollectorTileRowWidget extends ConsumerWidget {
  const CollectorTileRowWidget({
    super.key,
    required this.collector,
  });

  final Collector collector;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectorsSwitchedOn = ref
        .watch(numberOfSectorsSwitchedOnProvider(collectorId: collector.id))
        .valueOrNull;

    return Row(
      children: [
        Text(collector.name),
        gapW8,
        if (sectorsSwitchedOn != null && sectorsSwitchedOn > 0)
          SectorsSwitchedOnCountBadge(
            itemsCount: sectorsSwitchedOn,
          ),
        gapW8,
        BatteryIndicator(
          collectorId: collector.id,
        ),
      ],
    );
  }
}
