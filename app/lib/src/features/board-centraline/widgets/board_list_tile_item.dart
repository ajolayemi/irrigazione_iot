import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screens/boards_list/dismiss_board_controller.dart';
import 'package:irrigazione_iot/src/features/board-centraline/widgets/board_battery_level_indicator.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_info_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_tablet_responsive_center.dart';

class BoardListTileItem extends ConsumerWidget {
  const BoardListTileItem({
    super.key,
    required this.board,
  });

  final Board board;

  void _onTap(BuildContext context) {
    final params = PathParameters(id: board.id).toJson();
    context.pushNamed(
      AppRoute.boardDetails.name,
      pathParameters: params,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeleting = ref.watch(dismissBoardControllerProvider).isLoading;
    return CommonTabletResponsiveCenter(
      padding: EdgeInsets.zero,
      child: IgnorePointer(
        ignoring: isDeleting,
        child: InkWell(
          onTap: () => _onTap(context),
          child: ListTile(
            leading: CommonInfoIconButton(
              onPressed: () => _onTap(context),
            ),
            title: Text(board.name),
            trailing: BoardBatteryLevelIndicator(boardId: board.id),
          ),
        ),
      ),
    );
  }
}
