import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_statistic_repository.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_expansion_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

/// The expansion tile section of pump details screen to display pump statistics
class PumpDetailsStatistics extends ConsumerWidget {
  const PumpDetailsStatistics({
    super.key,
    required this.pumpId,
  });

  final String pumpId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // TODO: add litres per second, it should replace litres dispensed overtime
    // TODO: rename Statitics to Status

    final loc = context.loc;
    final lastPressure =
        ref.watch(pumpLastPressureStreamProvider(pumpId)).valueOrNull;
    final lastPressureDate = context.timeAgo(lastPressure?.createdAt);
    return CommonExpansionTile(
      title: loc.entityStatistics,
      children: [
        // Pump total dispensed litres
        Consumer(
          builder: (context, ref, child) {
            final litresDispensed = ref
                .watch(
                  pumpTotalDispensedLitresProvider(pumpId),
                )
                .value;
            return ResponsiveDetailsCard(
              child: DetailTileWidget(
                title: loc.pumpTotalDispensedLitres,
                subtitle: '${litresDispensed.toString()} L',
              ),
            );
          },
        ),

        // Last filter in pressure read
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.lastFilterInPressure,
            subtitle:
                '${lastPressure?.filterInPressure.toStringAsFixed(1) ?? '-'} bar ($lastPressureDate)',
          ),
        ),

        // Last filter out pressure read
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.lastFilterOutPressure,
            subtitle:
                '${lastPressure?.filterOutPressure.toStringAsFixed(1) ?? '-'} bar ($lastPressureDate)',
          ),
        ),

        // last pressure difference
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.lastFilterPressureDifference,
            subtitle:
                '${lastPressure?.pressureDifference.toStringAsFixed(1) ?? '-'} bar ($lastPressureDate)',
          ),
        ),

        gapH16,
      ],
    );
  }
}
