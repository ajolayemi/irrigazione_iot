import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/utils/date_formatter.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';

class PumpDetailsList extends ConsumerWidget {
  const PumpDetailsList({super.key, required this.pump});

  final Pump pump;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        ResponsiveDetailsCard(child: Consumer(builder: (context, ref, child) {
          final lastDispensation =
              ref.watch(lastDispensationStreamProvider(pump.id)).valueOrNull;
          final dateFormatter = ref.watch(dateFormatWithTimeProvider);
          return DetailTileWidget(
            title: loc.pumpLastDispensationForTile,
            subtitle: lastDispensation == null
                ? loc.pumpLastDispensationEmpty
                : dateFormatter.format(lastDispensation),
          );
        })),
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
