import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/battery_level_indicator.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
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
    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: replace with actual state
    const isDeleting = false;
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
              onTap: () => showNotImplementedAlertDialog(context: context),
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
