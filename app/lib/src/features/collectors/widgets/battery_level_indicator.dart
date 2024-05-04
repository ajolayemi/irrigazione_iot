import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';


/// A widget that displays the battery level of entities like sensors or boards.
class BatteryLevelIndicator extends ConsumerWidget {
  const BatteryLevelIndicator({super.key, required this.batteryLevel});

  final double batteryLevel;
  // Determine battery color based on level
  Color _getBatteryColor(double level) {
    if (level >= 75) {
      return Colors.green;
    } else if (level >= 40) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${batteryLevel.toStringAsFixed(0)}%',
          style: TextStyle(
            color: _getBatteryColor(batteryLevel),
          ),
        ),
        gapW8,
        Container(
          width: 30, // Set the width of the battery icon
          height: 15, // Set the height of the battery icon
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: batteryLevel  /
                      100, // Size factor based on battery level
                  child: Container(
                    decoration: BoxDecoration(
                      color: _getBatteryColor(batteryLevel),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
