import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/sector_list/sector_list_tile.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

class CollectorExpansionListTile extends ConsumerStatefulWidget {
  const CollectorExpansionListTile({
    super.key,
    required this.collector,
  });

  final Collector collector;

  // Key for testing using find.byKey
  static Key collectorExpansionListTileKey(Collector collector) =>
      Key('collectorExpansionListTileKey_${collector.id}');

  @override
  ConsumerState<CollectorExpansionListTile> createState() =>
      _CollectorExpansionListTileState();
}

class _CollectorExpansionListTileState
    extends ConsumerState<CollectorExpansionListTile> {
  bool _isExpanded = false;
  
  @override
  Widget build(BuildContext context) {
    final collectorSectors = ref
        .watch(collectorSectorsStreamProvider(widget.collector.id))
        .valueOrNull;
    return ResponsiveCenter(
      padding: _isExpanded
          ? const EdgeInsets.only(left: Sizes.p8, right: Sizes.p8)
          : const EdgeInsets.all(0),
      maxContentWidth: Breakpoint.tablet,
      child: ExpansionTile(
        expandedCrossAxisAlignment: CrossAxisAlignment.end,
        onExpansionChanged: (value) => setState(() => _isExpanded = value),
        leading: _isExpanded
            ? null
            : IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () => context.pushNamed(
                  AppRoute.collectorDetails.name,
                  pathParameters: {
                    'collectorId': widget.collector.id,
                  },
                ),
              ),
        title: Text(widget.collector.name),
        children: collectorSectors == null || collectorSectors.isEmpty
            ? []
            : collectorSectors
                .map(
                  (collectorSector) => CollectorExpansionTileChildItem(
                    sectorID: collectorSector!.sectorId,
                  ),
                )
                .toList(),
      ),
    );
  }
}

class CollectorExpansionTileChildItem extends ConsumerWidget {
  const CollectorExpansionTileChildItem({
    super.key,
    required this.sectorID,
  });

  final SectorID sectorID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sector = ref.watch(sectorStreamProvider(sectorID)).valueOrNull;
    if (sector == null) {
      return const SizedBox();
    }

    return SectorListTileItem(sector: sector);
  }
}
