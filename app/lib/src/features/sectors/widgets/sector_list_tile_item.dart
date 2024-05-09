import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_list/dismiss_sector_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_switch.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_switch_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sector_list_tile_subtitle.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sector_tile_title.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_tablet_responsive_center.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';

class SectorListTileItem extends ConsumerWidget {
  const SectorListTileItem({
    super.key,
    required this.sector,
  });

  final Sector sector;

  void _onTap(BuildContext context) {
    final params = PathParameters(id: sector.id).toJson();
    context.goNamed(
      AppRoute.sectorDetails.name,
      pathParameters: params,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalLoadingState =
        ref.watch(sectorSwitchControllerProvider).isGlobalLoading;
    final isDeleting = ref.watch(dismissSectorControllerProvider).isLoading;
    return CommonTabletResponsiveCenter(
      child: IgnorePointer(
        ignoring: isDeleting || globalLoadingState,
        child: InkWell(
          onTap: () => _onTap(context),
          child: ListTile(
            isThreeLine: true,
            title: SectorTileTitle(sector: sector),
            subtitle: SectorListTileSubtitle(sector: sector),
            trailing: SectorSwitch(sector: sector),
          ),
        ),
      ),
    );
  }
}
