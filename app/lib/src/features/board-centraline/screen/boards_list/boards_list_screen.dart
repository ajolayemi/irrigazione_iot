import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screen/boards_list/boards_list_tile.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screen/boards_list/dismiss_board_controller.dart';
import 'package:irrigazione_iot/src/features/board-centraline/widgets/empty_board_widget.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_sliver_list_skeleton.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';

/// Displays a list of boards, i.e centraline in italian.
class BoardsListScreen extends ConsumerWidget {
  const BoardsListScreen({super.key});

  void _onTapAdd(
    BuildContext context,
    WidgetRef ref,
  ) {
    context.pushNamed(
      AppRoute.addBoard.name,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final boards = ref.watch(boardListStreamProvider);
    final ignoring = ref.watch(dismissBoardControllerProvider).isLoading;
    return IgnorePointer(
      ignoring: ignoring,
      child: Scaffold(
        body: PaddedSafeArea(
            child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: loc.iotBoardsMenuTitle,
              actions: [
                CommonAddIconButton(
                  onPressed: () => _onTapAdd(context, ref),
                ),
              ],
            ),
            AsyncValueSliverWidget(
                value: boards,
                data: (boards) {
                  if (boards.isEmpty) {
                    return const EmptyBoardWidget();
                  }

                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // It's safe to assume that board is not null
                      final board = boards[index]!;
                      return BoardListTile(board: board);
                    },
                    childCount: boards.length,
                  ));
                },
                loading: () => const CommonSliverListSkeleton(
                      hasLeading: false,
                    )),
          ],
        )),
      ),
    );
  }
}
