import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/app_sizes.dart';
import '../../board-centraline/data/board_repository.dart';
import 'battery_level_indicator.dart';
import 'filter_pressure_diff_widget.dart';

/// A row widget that displays the battery level and the filter pressure difference
class CollectorTileSubtitle extends ConsumerWidget {
  const CollectorTileSubtitle({
    super.key,
    required this.collectorId,
  });

  final String collectorId;

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
              return const SizedBox();
            }
            return BatteryIndicator(
              boardId: board.id,
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
