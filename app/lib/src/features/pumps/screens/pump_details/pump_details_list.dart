import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';

import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_details_characteristics.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_details_last_dispensation_card.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_details_statistics.dart';

class PumpDetailsList extends ConsumerWidget {
  const PumpDetailsList({super.key, required this.pump});

  final Pump pump;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        PumpDetailsLastDispensationCard(pumpId: pump.id),
        gapH8,
        PumpDetailsCharacteristics(pump: pump),
        gapH4,
        PumpDetailsStatistics(pumpId: pump.id),
      ]),
    );
  }
}
