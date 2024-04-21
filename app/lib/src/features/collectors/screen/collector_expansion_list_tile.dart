import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/routes/routes_enums.dart';

import '../../../constants/app_sizes.dart';
import '../../../constants/breakpoints.dart';
import '../data/collector_sector_repository.dart';
import '../model/collector.dart';
import 'collector_list/dismiss_collector_controller.dart';
import '../widgets/collector_tile_subtitle.dart';
import '../widgets/collector_tile_title.dart';
import '../../sectors/data/sector_repository.dart';
import '../../sectors/model/sector.dart';
import '../../sectors/screen/sector_list/sector_list_tile.dart';
import '../../../utils/extensions.dart';
import '../../../widgets/alert_dialogs.dart';
import '../../../widgets/custom_dismissible.dart';
import '../../../widgets/responsive_center.dart';

class CollectorExpansionListTile extends ConsumerStatefulWidget {
  const CollectorExpansionListTile({
    super.key,
    required this.collector,
  });

  final Collector collector;

  @override
  ConsumerState<CollectorExpansionListTile> createState() =>
      _CollectorExpansionListTileState();
}

class _CollectorExpansionListTileState
    extends ConsumerState<CollectorExpansionListTile> {
  bool _isExpanded = false;

  // Key for testing using find.byKey
  static Key collectorExpansionListTileKey(Collector collector) =>
      Key('collectorExpansionListTileKey_${collector.id}');

  Future<bool> _dismissCollector(BuildContext context, WidgetRef ref) async {
    final loc = context.loc;
    final shouldDismiss = await showAlertDialog(
          context: context,
          title: loc.genericAlertDialogTitle,
          content: loc.deleteConfirmationDialogTitle(
            loc.nCollectorsWithArticulatedPreposition(1),
          ),
          defaultActionText: loc.alertDialogDelete,
          cancelActionText: loc.alertDialogCancel,
        ) ??
        false;
    if (!shouldDismiss) return false;

    return ref
        .read(dismissCollectorControllerProvider.notifier)
        .confirmDismiss(widget.collector.id);
  }

  @override
  Widget build(BuildContext context) {
    final collectorSectors = ref
        .watch(collectorSectorsStreamProvider(widget.collector.id))
        .valueOrNull;
    final isDeleting = ref.watch(dismissCollectorControllerProvider).isLoading;
    return IgnorePointer(
      ignoring: isDeleting,
      child: CustomDismissibleWidget(
        dismissibleKey: collectorExpansionListTileKey(widget.collector),
        isDeleting: isDeleting,
        confirmDismiss: (_) async => await _dismissCollector(
          context,
          ref,
        ),
        child: ResponsiveCenter(
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
            title: CollectorTileRowWidget(collector: widget.collector),
            subtitle: CollectorTileSubtitle(collectorId: widget.collector.id),
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
        ),
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
