import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_list/dismiss_sector_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_switch_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sector_list_tile_item.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_dismissible.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_center.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';

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
    final askUser = await showAlertDialog(
          context: context,
          title: loc.genericAlertDialogTitle,
          content: loc.deleteConfirmationDialogTitle(
            loc.nSectorsWithArticulatedPreposition(1),
          ),
          defaultActionText: loc.alertDialogDelete,
          cancelActionText: loc.alertDialogCancel,
        ) ??
        false;
    if (!askUser) return false;
    return ref
        .read(dismissSectorControllerProvider.notifier)
        .confirmDismiss(sector.id);
  }

  void _onTap(BuildContext context) {
    final params = PathParameters(
      id: sector.id,
    ).toJson();
    context.goNamed(
      AppRoute.sectorDetails.name,
      pathParameters: params,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // todo: add sector pressure in the list tile subtitle
    // todo: irrigation state (manual/automatic)
    // todo: since when is this sector being irrigated if on
    // todo: for when program will be available, show countdown for remaining time
    final globalLoadingState =
        ref.watch(sectorSwitchControllerProvider).isGlobalLoading;
    final isDeleting = ref.watch(dismissSectorControllerProvider).isLoading;
    return ResponsiveCenter(
      padding: const EdgeInsets.only(left: Sizes.p8),
      maxContentWidth: Breakpoint.tablet,
      child: InkWell(
        onTap: globalLoadingState ? null : () => _onTap(context),
        child: CustomDismissibleWidget(
          dismissibleKey: sectorListTileKey(sector),
          isDeleting: isDeleting,
          confirmDismiss: (_) async => await _dismissSector(context, ref),
          child: SectorListTileItem(sector: sector),
        ),
      ),
    );
  }
}
