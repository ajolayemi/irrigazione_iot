import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_details_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/pump_status/pump_status_tile_wid.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/widgets/responsive_details_card.dart';

class PumpDetailsSliverList extends ConsumerWidget {
  const PumpDetailsSliverList({super.key, required this.pump});

  final Pump pump;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        ResponsiveDetailsCard(
          child: PumpStatusTileWidget(
            pump: pump,
            title: context.loc.statusListTileTitle,
          ),
        ),
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: 'Capacity in volume',
            subtitle: '${pump.capacityInVolume.toString()} m³',
          ),
        ),
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: 'Consume rate in kW',
            subtitle: '${pump.consumeRateInKw.toString()} kW',
          ),
        ),

        Consumer(
          builder: (context, ref, child) {
            final litresDispensed = ref.watch(pumpTotalDispensedLitresProvider(pump.id)).value;
            return ResponsiveDetailsCard(
              child: DetailTileWidget(
                title: 'Total litres dispensed',
                subtitle: '${litresDispensed.toString()} L',
              ),
            );
          },
        )
      
      ]),
    );
  }
}




