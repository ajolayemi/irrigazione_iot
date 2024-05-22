import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_status_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/battery_level_indicator.dart';

class BoardBatteryLevelIndicator extends ConsumerWidget {
  const BoardBatteryLevelIndicator({
    super.key,
    required this.boardId,
  });

  final String boardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardStatus =
        ref.watch(boardStatusStreamProvider(boardID: boardId)).valueOrNull;

    final batteryLevel = (boardStatus?.batteryLevel ?? 0.0);
    return BatteryLevelIndicator(batteryLevel: batteryLevel);
  }
}
