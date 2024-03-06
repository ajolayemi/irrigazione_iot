import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/presentation/sector_list/sector_list_tile_subtitle.dart';
import 'package:irrigazione_iot/src/features/sectors/presentation/sector_switch.dart';
import 'package:irrigazione_iot/src/features/sectors/presentation/sector_switch_controller.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

class SectorListTile extends ConsumerWidget {
  const SectorListTile({
    super.key,
    required this.sector,
  });

  final Sector sector;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalLoadingState =
        ref.watch(sectorSwitchControllerProvider).isGlobalLoading;
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
        child: ListTile(
          title: Text(sector.name),
          subtitleTextStyle: context.textTheme.titleSmall?.copyWith(
            color: Colors.grey,
          ),
          isThreeLine: true,
          subtitle: SectorListTileSubtitle(sector: sector),
          trailing: SectorSwitch(
            sector: sector,
          ),
          // onTap: () => context.goNamed(
          //   AppRoute.sectorDetails.name,
          //   pathParameters: {
          //     'sectorId': sector.id,
          //   },
          // ),
        ),
      ),
    );
  }
}
