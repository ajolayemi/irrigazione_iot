import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';

class ProviderUtils {
  const ProviderUtils._();

  /// Helper function to invalidate states of various providers
  /// Connected to the board entity
  static void invalidateBoardStates({
    required Ref ref,
    Board? board,
  }) {
    // Invalidate general list of boards provider
    ref.invalidate(boardsListProvider);

    if (board != null) {
      // Invalidate the specific board provider
      ref.invalidate(boardProvider(boardId: board.id));

      // Invalidate the collector board provider
      ref.invalidate(collectorBoardProvider(collectorId: board.collectorId));
    }

    // Invalidate the provider that holds list of used board names
    ref.invalidate(usedBoardNamesProvider);
  }
}
