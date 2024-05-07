import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_expansion_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';

/// The expansion tile section of pump details screen to display pump characteristics
class PumpDetailsCharacteristics extends ConsumerWidget {
  const PumpDetailsCharacteristics({
    super.key,
    required this.pump,
  });

  final Pump pump;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return CommonExpansionTile(
      title: loc.entityCharacteristics,
      children: [
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
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.itemHasFilter,
            subtitle: pump.hasFilter ? loc.yes : loc.no,
          ),
        ),
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.mqttMessageNameFormFieldTitle,
            subtitle: pump.mqttMessageName,
          ),
        ),
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.mqttOnCommand,
            subtitle: pump.turnOnCommand,
          ),
        ),
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.mqttOffCommand,
            subtitle: pump.turnOffCommand,
          ),
        ),
        gapH16,
      ],
    );
  }
}
