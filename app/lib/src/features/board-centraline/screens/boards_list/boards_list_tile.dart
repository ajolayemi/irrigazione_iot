import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_status_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screens/boards_list/dismiss_board_controller.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/battery_level_indicator.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_dismissible.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_center.dart';

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

  void _onTap(BuildContext context) {
    final params = PathParameters(id: board.id).toJson();
    context.pushNamed(AppRoute.boardDetails.name, pathParameters: params);
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
              onTap: () => _onTap(context),
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
      trailing: BoardBatteryLevelIndicator(boardId: board.id),
    );
  }
}

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

    final batteryLevel = (boardStatus?.batteryLevel ?? 0.0) * 100;
    return BatteryLevelIndicator(batteryLevel: batteryLevel);
  }
}
