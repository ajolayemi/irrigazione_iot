import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pressure_repository.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class SectorDetailsLastPressureCard extends ConsumerWidget {
  const SectorDetailsLastPressureCard({super.key, required this.sectorId});
  final String sectorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final lastPressure =
        ref.watch(sectorLastPressureStreamProvider(sectorId)).valueOrNull;
    return ResponsiveDetailsCard(
      child: DetailTileWidget(
          title: loc.pressure,
          subtitle: '${lastPressure?.pressure.toString()} bar'),
    );
  }
}
