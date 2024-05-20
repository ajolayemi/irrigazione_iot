import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/dashboard_child_item_details_row.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';

/// Displays the current flow rate of the pump.
class PumpFlowRate extends ConsumerWidget {
  const PumpFlowRate({
    super.key,
    required this.pumpId,
  });

  final String pumpId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pumpFlow = ref.watch(pumpLastFlowStreamProvider(pumpId)).valueOrNull;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardChildItemDetailsRow(
          leading: const Text('Litri erogati'),
          trailing: Text('${pumpFlow?.flow ?? 0}'),
        ),
        DashboardChildItemDetailsRow(
          leading: const Text('Portata'),
          trailing:
              Text('${pumpFlow?.litresPerSecond.toStringAsFixed(2) ?? 0} l/s'),
        ),
      ],
    );
  }
}
