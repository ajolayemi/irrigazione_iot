import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_expansion_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

/// The expansion tile section of pump details screen to display pump statistics
class PumpDetailsStatistics extends ConsumerWidget {
  const PumpDetailsStatistics({
    super.key,
    required this.pumpId,
  });

  final String pumpId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return CommonExpansionTile(
      title: loc.entityStatistics,
      children: [
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
        gapH16,
      ],
    );
  }
}
