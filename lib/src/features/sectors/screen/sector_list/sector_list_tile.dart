import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/sector_list/dismiss_sector_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/sector_list/sector_list_tile_subtitle.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/sector_switch.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/sector_switch_controller.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/custom_dismissible.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalLoadingState =
        ref.watch(sectorSwitchControllerProvider).isGlobalLoading;
    final isDeleting = ref.watch(dismissSectorControllerProvider).isLoading;
    return ResponsiveCenter(
      padding: const EdgeInsets.only(left: Sizes.p8),
      maxContentWidth: Breakpoint.tablet,
      child: InkWell(
        onTap: globalLoadingState
            ? null
            : () => context.goNamed(
                  AppRoute.sectorDetails.name,
                  pathParameters: {
                    'sectorId': sector.id,
                  },
                ),
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

class SectorListTileItem extends StatelessWidget {
  const SectorListTileItem({
    super.key,
    required this.sector,
  });

  final Sector sector;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(sector.name),
        subtitleTextStyle: context.textTheme.titleSmall?.copyWith(
          color: Colors.grey,
        ),
        isThreeLine: true,
        subtitle: SectorListTileSubtitle(sector: sector),
        trailing: SectorSwitch(
          sector: sector,
        ));
  }
}
