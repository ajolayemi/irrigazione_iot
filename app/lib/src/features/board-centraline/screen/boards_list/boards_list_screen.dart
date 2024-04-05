import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/routes_enums.dart';
import '../../data/board_repository.dart';
import 'boards_list_tile.dart';
import 'dismiss_board_controller.dart';
import '../../widgets/empty_board_widget.dart';
import '../../../../utils/extensions.dart';
import '../../../../widgets/app_sliver_bar.dart';
import '../../../../widgets/async_value_widget.dart';
import '../../../../widgets/common_add_icon_button.dart';
import '../../../../widgets/common_sliver_list_skeleton.dart';
import '../../../../widgets/padded_safe_area.dart';

/// Displays a list of boards, i.e centraline in italian.
class BoardsListScreen extends ConsumerWidget {
  const BoardsListScreen({super.key});

  void _onTapAdd(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.read(collectorConnectedToBoardProvider.notifier).state = null;
    ref.read(selectedCollectorIdProvider.notifier).state = null;
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