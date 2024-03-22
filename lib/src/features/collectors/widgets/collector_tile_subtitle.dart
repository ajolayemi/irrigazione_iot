import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
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
            /// Get the board (centralina) that is linked to this collector
            final board = ref
                .watch(collectorBoardStreamProvider(collectorID: collectorId))
                .valueOrNull;

            /// If the board is null, return an empty widget
            if (board == null) {
              return const SliverToBoxAdapter();
            }
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
