import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_details_last_dispensation_card.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class PumpDetailsList extends ConsumerWidget {
  const PumpDetailsList({super.key, required this.pump});

  final Pump pump;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        PumpDetailsLastDispensationCard(pumpId: pump.id),
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.pumpVolumeCapacityFormFieldTitle,
            subtitle: '${pump.capacityInVolume.toString()} m³',
          ),
        ),
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.pumpKwFormFieldTitle,
            subtitle: '${pump.consumeRateInKw.toString()} kW',
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final litresDispensed =
                ref.watch(pumpTotalDispensedLitresProvider(pump.id)).value;
            return ResponsiveDetailsCard(
              child: DetailTileWidget(
                title: loc.pumpTotalDispensedLitres,
                subtitle: '${litresDispensed.toString()} L',
              ),
            );
          },
        )
      ]),
    );
  }
}
