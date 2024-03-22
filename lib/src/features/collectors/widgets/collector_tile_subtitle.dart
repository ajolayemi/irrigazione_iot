import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/battery_level_indicator.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/filter_pressure_diff_widget.dart';

/// A row widget that displays the battery level and the filter pressure difference
class CollectorTileSubtitle extends ConsumerWidget {
  const CollectorTileSubtitle({
    super.key,
    required this.collectorId,
  });

  final CollectorID collectorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Consumer(
          builder: (context, ref, child) {
            return BatteryIndicator(
              collectorId: collectorId,
            );
          },
        ),
        gapW8,
        CollectorFilterPressureDifference(
          collectorId: collectorId,
        )
      ],
    );
  }
}
