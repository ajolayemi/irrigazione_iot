import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/features/sectors/data/sector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';
import 'package:irrigazione_iot/src/features/variety/data/variety_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class SectorListTileSubtitle extends ConsumerWidget {
  const SectorListTileSubtitle({super.key, required this.sector});

  final Sector sector;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectorVariety =
        ref.watch(varietyStreamProvider(sector.varietyId)).valueOrNull;
    final sectorSpecie =
        ref.watch(specieStreamProvider(sector.specieId)).valueOrNull;
    final varietySpecie = sectorVariety != null && sectorSpecie != null
        ? '${sectorSpecie.name} ${sectorVariety.name}'
        : context.loc.notAvailable;

    // TODO: the details screen should follow the same structure as that of pumps
    // TODO: add Connected Sensors to the sector details screen

    final lastIrrigatedDate =
        ref.watch(sectorLastPressureStreamProvider(sector.id)).valueOrNull;
    final lastIrrigatedString = context.timeAgo(
      lastIrrigatedDate,
      fallbackValue: context.loc.notAvailable,
    );
    return Text(
      '$varietySpecie\n${context.loc.sectorLastIrrigation(
        lastIrrigatedString,
      )}',
      style: context.textTheme.titleSmall?.copyWith(
        color: Colors.grey,
      ),
    );
  }
}
