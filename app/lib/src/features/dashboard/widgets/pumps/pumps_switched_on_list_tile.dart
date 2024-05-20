import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/pump_statuses_stat.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/pumps/pump_flow_rate.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/pumps/pump_irrigation_duration.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/pumps/pump_pressure_rate.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_tile_title.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class PumpSwitchedOnListTile extends ConsumerWidget {
  const PumpSwitchedOnListTile({
    super.key,
    required this.pumpStatusStat,
  });

  final PumpStatusesStat pumpStatusStat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    final pump =
        ref.watch(pumpStreamProvider(pumpStatusStat.pumpId)).valueOrNull;
    if (pump == null) return Container();

    return ListTile(
      title: PumpTileTitle(
        pump: pump,
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH8,
          PumpPressureRate(pumpId: pump.id),
          gapH8,
          PumpFlowRate(pumpId: pump.id),
          gapH8,
          PumpIrrigationDuration(pumpId: pump.id),
        ],
      ),
    );
  }
}
