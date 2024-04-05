import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/sector_status_repository.dart';
import '../../model/sector.dart';
import '../../../../utils/date_formatter.dart';
import '../../../../utils/extensions.dart';

class SectorListTileSubtitle extends ConsumerWidget {
  const SectorListTileSubtitle({super.key, required this.sector});

  final Sector sector;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: add after sector name an indicator to show whether a sector is on
    // TODO: sector list tile should become ExpansionTile
    // TODO: when expanded, user should see
    // TODO: - switch to turn on/off the sector
    // TODO: - if on/off, last irrigation date and duration (how long was the last irrigation and litres consumed per plants)
    // TODO: - if on, since when is this sector being irrigated
    // TODO: - if on and automatic, how much longer till the end
    // TODO: - average litres/plant in the last 7 days
    // TODO: last irrigation date should follow this format
    // TODO: esempio dom. 31 marzo 12:00 (giorno e ore, 2 gg e 3 ore fa or 1 ora fa )
    // TODO: second case for when it's <= a single day difference

    // TODO: Expansion tile is not needed anymore
    // TODO: the details screen should follow the same structure as that of pumps
    // TODO: add Connected Sensors to the sector details screen
    final dateFormatter = ref.watch(dateFormatWithTimeProvider);
    final lastIrrigatedDate =
        ref.watch(sectorLastIrrigatedStreamProvider(sector)).valueOrNull;
    final lastIrrigatedString = lastIrrigatedDate != null
        ? dateFormatter.format(lastIrrigatedDate)
        : context.loc.notAvailable;
    return Text(
      '${sector.displayName}\n${context.loc.sectorLastIrrigation(
        lastIrrigatedString, 
      )}',
    );
  }
}