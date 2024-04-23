import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_pressure_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class CollectorFilterPressureDifference extends ConsumerWidget {
  const CollectorFilterPressureDifference({
    super.key,
    required this.collectorId,
  });

  final String collectorId;

  // Determine battery color based on level
  Color _getPressureColor(double pressureDifference) {
    if (pressureDifference >= 0.7) {
      return Colors.red;
    } else if (pressureDifference >= 0.5) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pressures = ref
        .watch(collectorPressureStreamProvider(collectorId))
        .valueOrNull;
    double pressureDifference =
        pressures == null ? 0.0 : pressures.pressureDifference;
    return Row(
      children: [
        Text(
          '${context.loc.filterPressureDifference} ',
          textScaler: const TextScaler.linear(1),
        ),
        Text(
          pressureDifference.toStringAsFixed(2),
          textScaler: const TextScaler.linear(1),
          style: TextStyle(
            color: _getPressureColor(pressureDifference),
          ),
        ),
      ],
    );
  }
}
