import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/app_sizes.dart';
import '../data/collector_sector_repository.dart';
import '../model/collector.dart';
import 'sectors_switched_on_badge.dart';


/// A row widget that displays the collector name and the number of sectors switched on
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(collector.name),
        gapW8,
        if (sectorsSwitchedOn != null && sectorsSwitchedOn > 0)
          SectorsSwitchedOnCountBadge(
            itemsCount: sectorsSwitchedOn,
          ),
      ],
    );
  }
}


