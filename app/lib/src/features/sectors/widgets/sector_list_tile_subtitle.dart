import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/styles/app_styles.dart';

import 'package:irrigazione_iot/src/features/sectors/data/sector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';
import 'package:irrigazione_iot/src/features/variety/data/variety_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class SectorListTileSubtitle extends ConsumerWidget {
  const SectorListTileSubtitle({super.key, required this.sector});

  final Sector sector;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final sectorVariety =
        ref.watch(varietyFutureProvider(sector.varietyId)).valueOrNull;
    final sectorSpecie =
        ref.watch(specieFutureProvider(sector.specieId)).valueOrNull;
    final varietySpecie = sectorVariety != null && sectorSpecie != null
        ? '${sectorSpecie.name} ${sectorVariety.name}'
        : context.loc.notAvailable;

    return Consumer(
      builder: (context, ref, child) {
        final lastPressureReading =
            ref.watch(sectorLastPressureStreamProvider(sector.id)).valueOrNull;
        final lastIrrigatedString = context.timeAgo(
          lastPressureReading?.createdAt,
          fallbackValue: loc.notAvailable,
        );
        return Text(
          '$varietySpecie\n${loc.sectorLastIrrigation(
            lastIrrigatedString,
          )}',
          style: context.commonSubtitleStyle,
        );
      },
    );
  }
}
