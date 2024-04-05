import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/pump_details_repository.dart';
import '../../data/pump_status_repository.dart';
import '../../model/pump.dart';
import '../pump_status_switch.dart';
import '../../../../utils/date_formatter.dart';
import '../../../../utils/extensions.dart';
import '../../../../widgets/details_tile_widget.dart';
import '../../../../widgets/responsive_details_card.dart';

class PumpDetailsList extends ConsumerWidget {
  const PumpDetailsList({super.key, required this.pump});

  final Pump pump;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        // ResponsiveDetailsCard(
        //   child: Consumer(
        //     builder: (context, ref, child) {
        //       final status =
        //           ref.watch(pumpStatusStreamProvider(pump)).valueOrNull ??
        //               false;
        //       return DetailTileWidget(
        //         title: loc.statusListTileTitle,
        //         subtitle: status ? loc.onStatusValue : loc.offStatusValue,
        //         trailing: PumpSwitch(pump: pump),
        //       );
        //     },
        //   ),
        // ),
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
