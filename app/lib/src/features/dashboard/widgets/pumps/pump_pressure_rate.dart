import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/dashboard_child_item_details_row.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/common_pressure_rate_trailing_text.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_statistic_repository.dart';

/// Displays the current pressure rate of the pump.
class PumpPressureRate extends ConsumerWidget {
  const PumpPressureRate({
    super.key,
    required this.pumpId,
  });

  final String pumpId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pumpPressure =
        ref.watch(pumpLastPressureStreamProvider(pumpId)).valueOrNull;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardChildItemDetailsRow(
          leading: const Text('Filter in'),
          trailing: CommonPressureRateTrailingText(
            pressure: pumpPressure?.filterInPressure ?? 0,
          ),
        ),
        DashboardChildItemDetailsRow(
          leading: const Text('Filter out'),
          trailing: CommonPressureRateTrailingText(
            pressure: pumpPressure?.filterOutPressure ?? 0,
          ),
        ),
        DashboardChildItemDetailsRow(
          leading: const Text('Filter diff'),
          trailing: CommonPressureRateTrailingText(
            pressure: pumpPressure?.pressureDifference ?? 0,
          ),
        ),
      ],
    );
  }
}
