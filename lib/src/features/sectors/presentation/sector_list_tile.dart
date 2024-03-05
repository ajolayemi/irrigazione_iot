import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/presentation/sector_list_tile_subtitle.dart';
import 'package:irrigazione_iot/src/features/sectors/presentation/sector_state_switch.dart';
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
    // todo return a widget to tell user that they don't have any sectors
    // todo allow user to tap on sector to view its details
    return ResponsiveCenter(
      padding: const EdgeInsets.only(left: Sizes.p8),
      maxContentWidth: Breakpoint.tablet,
      child: ListTile(
        title: Text(sector.name),
        subtitleTextStyle: context.textTheme.titleSmall?.copyWith(
          color: Colors.grey,
        ),
        isThreeLine: true,
        subtitle: SectorListTileSubtitle(sector: sector),
        trailing: SectorStateSwitch(sectorID: sector.id),
        // onTap: () => context.goNamed(
        //   AppRoute.sectorDetails.name,
        //   pathParameters: {
        //     'sectorId': sector.id,
        //   },
        // ),
      ),
    );
  }
}
