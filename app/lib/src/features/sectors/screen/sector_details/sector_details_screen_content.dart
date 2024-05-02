import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sector_details_characteristics.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sector_details_last_irrigation_card.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sector_details_last_pressure_card.dart';

class SectorDetailsScreenContents extends ConsumerWidget {
  const SectorDetailsScreenContents({super.key, required this.sector});

  final Sector sector;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          SectorDetailsLastIrrigationCard(sectorId: sector.id),
          SectorDetailsLastPressureCard(sectorId: sector.id),
          gapH8,
          SectorDetailsCharacteristics(sector: sector),
          gapH48,
        ],
      ),
    );
  }
}
