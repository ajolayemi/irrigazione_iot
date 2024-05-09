import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/features/authentication/role_management/data/role_management_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector.dart';
import 'package:irrigazione_iot/src/features/collectors/screens/collector_list/dismiss_collector_controller.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/collector_expansion_tile_child.dart';
import 'package:irrigazione_iot/src/shared/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_dismissible.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

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
  // Key for testing using find.byKey
  static Key collectorExpansionListTileKey(Collector collector) =>
      Key('collectorExpansionListTileKey_${collector.id}');

  bool _isExpanded = false;

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

    final canDelete =
        ref.watch(userCanDeleteStreamProvider).valueOrNull ?? false;

    return CustomDismissibleWidget(
      canDelete: canDelete,
      dismissibleKey: collectorExpansionListTileKey(widget.collector),
      isDeleting: isDeleting,
      confirmDismiss: (_) async => await _dismissCollector(context, ref),
      child: CollectorExpansionTileChildItem(
        collector: widget.collector,
        isDeleting: isDeleting,
        isExpanded: _isExpanded,
        onExpanded: (isExpanded) => setState(() => _isExpanded = isExpanded),
        collectorSectors: collectorSectors ?? [],
      ),
    );
  }
}
