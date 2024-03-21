import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/utils/date_formatter.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class SectorListTileSubtitle extends ConsumerWidget {
  const SectorListTileSubtitle({super.key, required this.sector});

  final Sector sector;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // todo: sector list tile should become ExpansionTile
    // todo: when expanded, user should see
    // todo: - switch to turn on/off the sector
    // todo: - if on/off, last irrigation date and duration (how long was the last irrigation and litres consumed per plants)
    // todo: - if on, since when is this sector being irrigated
    // todo: - if on and automatic, how much longer till the end
    // todo: - average litres/plant in the last 7 days
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
