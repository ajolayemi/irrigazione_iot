import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_status_indicator.dart';

class SectorTileTitle extends ConsumerWidget {
  const SectorTileTitle({super.key, required this.sector});

  final Sector sector;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSwitchedOn =
        ref.watch(sectorStatusStreamProvider(sector.id)).valueOrNull ?? false;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(sector.name),
        gapW8,
        CommonStatusIndicator(status: isSwitchedOn)
      ],
    );
  }
}