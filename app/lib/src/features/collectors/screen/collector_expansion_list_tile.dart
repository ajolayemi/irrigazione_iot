import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/collectors/screen/collector_list/dismiss_collector_controller.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/collector_tile_subtitle.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/collector_tile_title.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sector_list_tile_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_info_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_dismissible.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_center.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';

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
                : CommonInfoIconButton(
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

  final String sectorID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sector = ref.watch(sectorStreamProvider(sectorID)).valueOrNull;
    if (sector == null) {
      return const SizedBox();
    }

    return SectorListTileItem(sector: sector);
  }
}
