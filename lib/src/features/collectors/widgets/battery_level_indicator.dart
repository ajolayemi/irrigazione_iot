import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';

class BatteryIndicator extends ConsumerWidget {
  const BatteryIndicator({super.key, required this.boardId});

  final BoardID boardId;
  // Determine battery color based on level
  Color _getBatteryColor(double level) {
    if (level >= 0.75) {
      return Colors.green;
    } else if (level >= 0.4) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batteryLevel = ref
            .watch(collectorBatteryLevelStreamProvider(collectorId: boardId))
            .valueOrNull ??
        0.0;

    return Row(
      children: [
        const Icon(Icons.battery_charging_full),
        Text(
          '${(batteryLevel * 100).toStringAsFixed(0)}%',
          style: TextStyle(
            color: _getBatteryColor(batteryLevel),
          ),
        ),
      ],
    );
  }
}
