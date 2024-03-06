import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';
import 'package:irrigazione_iot/src/utils/date_formatter.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class SectorListTileSubtitle extends ConsumerWidget {
  const SectorListTileSubtitle({super.key, required this.sector});

  final Sector sector;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
