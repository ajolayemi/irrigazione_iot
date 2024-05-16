import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/authentication/role_management/data/role_management_repository.dart';

import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_list/dismiss_sector_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sector_list_tile_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_dismissible.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class SectorListTile extends ConsumerWidget {
  const SectorListTile({
    super.key,
    required this.sector,
  });

  final Sector sector;

  // Key for testing using find.byKey
  static Key sectorListTileKey(Sector sector) =>
      Key('sectorListTileKey_${sector.id}');

  Future<bool> _dismissSector(BuildContext context, WidgetRef ref) async {
    final loc = context.loc;
    final askUser = await context.showDismissalDialog(
      where: loc.nSectorsWithArticulatedPreposition(1),
    );
    if (!askUser) return false;
    return ref
        .read(dismissSectorControllerProvider.notifier)
        .confirmDismiss(sector.id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeleting = ref.watch(dismissSectorControllerProvider).isLoading;
    final canDelete =
        ref.watch(userCanDeleteStreamProvider).valueOrNull ?? false;
    return CustomDismissibleWidget(
      canDelete: canDelete,
      dismissibleKey: sectorListTileKey(sector),
      isDeleting: isDeleting,
      confirmDismiss: (_) async => await _dismissSector(context, ref),
      child: SectorListTileItem(sector: sector),
    );
  }
}
