import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/features/authentication/role_management/data/role_management_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screens/boards_list/dismiss_board_controller.dart';
import 'package:irrigazione_iot/src/features/board-centraline/widgets/board_list_tile_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_dismissible.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class BoardListTile extends ConsumerWidget {
  const BoardListTile({
    super.key,
    required this.board,
  });

  final Board board;

  // Key for testing using find.byKey
  static Key boardListTileKey(Board board) =>
      Key('boardListTileKey_${board.id}');

  Future<bool> _dismissBoard(BuildContext context, WidgetRef ref) async {
    final where = context.loc.nBoardsWithArticulatedPreposition(1);
    if (await context.showDismissalDialog(where: where)) {
      return await ref
          .read(dismissBoardControllerProvider.notifier)
          .confirmDismiss(board.id);
    }
    return false;
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeleting = ref.watch(dismissBoardControllerProvider).isLoading;
    final canDelete =
        ref.watch(userCanDeleteStreamProvider).valueOrNull ?? false;
    return CustomDismissibleWidget(
      canDelete: canDelete,
      dismissibleKey: boardListTileKey(board),
      confirmDismiss: (_) async => await _dismissBoard(context, ref),
      isDeleting: isDeleting,
      child: BoardListTileItem(board: board),
    );
  }
}
