import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector_sector.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/collector_tile_subtitle.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/collector_tile_title.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sector_list_tile_item.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_info_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_tablet_responsive_center.dart';

class CollectorExpansionTileChildItem extends ConsumerWidget {
  const CollectorExpansionTileChildItem({
    super.key,
    required this.collector,
    required this.isDeleting,
    required this.isExpanded,
    required this.onExpanded,
    required this.collectorSectors,
  });

  final Collector collector;
  final bool isDeleting;
  final bool isExpanded;
  final Function(bool) onExpanded;
  final List<CollectorSector?> collectorSectors;

  void _navigateToCollectorDetails(BuildContext context) {
    final pathParam = PathParameters(id: collector.id).toJson();
    context.pushNamed(
      AppRoute.collectorDetails.name,
      pathParameters: pathParam,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonTabletResponsiveCenter(
      child: IgnorePointer(
        ignoring: isDeleting,
        child: ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.end,
          onExpansionChanged: onExpanded,
          leading: isExpanded
              ? null
              : CommonInfoIconButton(
                  onPressed: () => _navigateToCollectorDetails(context),
                ),
          title: CollectorTileRowWidget(collector: collector),
          subtitle: CollectorTileSubtitle(collectorId: collector.id),
          children: collectorSectors.isEmpty
              ? []
              : collectorSectors.map((collectorSector) => Consumer(
                builder: (context, ref, child) {
                  final sector = ref.watch(sectorStreamProvider(collectorSector!.sectorId)).valueOrNull;
                  if (sector == null) {
                    return const SizedBox();
                  }
                  return SectorListTileItem(sector: sector);
                },
              )).toList(),
        ),
      ),
    );
  }
}
