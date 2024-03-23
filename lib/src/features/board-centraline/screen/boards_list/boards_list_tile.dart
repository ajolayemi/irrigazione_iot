import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screen/boards_list/dismiss_board_controller.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/battery_level_indicator.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/custom_dismissible.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

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
    if (await context.showDismissalDialog(where)) {
      return await ref
          .read(dismissBoardControllerProvider.notifier)
          .confirmDismiss(board.id);
    }
    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeleting = ref.watch(dismissBoardControllerProvider).isLoading;
    return IgnorePointer(
      ignoring: isDeleting,
      child: CustomDismissibleWidget(
          dismissibleKey: boardListTileKey(board),
          confirmDismiss: (_) async => await _dismissBoard(context, ref),
          isDeleting: isDeleting,
          child: ResponsiveCenter(
            padding: const EdgeInsets.only(left: Sizes.p8),
            maxContentWidth: Breakpoint.tablet,
            child: InkWell(
              onTap: () => context
                  .pushNamed(AppRoute.boardDetails.name, pathParameters: {
                'boardId': board.id.toString(),
              }),
              child: BoardListTileItem(board: board),
            ),
          )),
    );
  }
}

class BoardListTileItem extends StatelessWidget {
  const BoardListTileItem({
    super.key,
    required this.board,
  });

  final Board board;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(board.name),
      trailing: BatteryIndicator(boardId: board.id),
    );
  }
}
