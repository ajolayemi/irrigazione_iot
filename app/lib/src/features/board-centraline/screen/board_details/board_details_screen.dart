import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/routes_enums.dart';
import '../../data/board_repository.dart';
import '../../models/board.dart';
import 'board_details_screen_contents.dart';
import '../../../collectors/model/collector.dart';
import '../../../../widgets/app_sliver_bar.dart';
import '../../../../widgets/async_value_widget.dart';
import '../../../../widgets/common_sliver_list_skeleton.dart';
import '../../../../widgets/common_edit_icon_button.dart';
import '../../../../widgets/padded_safe_area.dart';

class BoardDetailsScreen extends ConsumerWidget {
  const BoardDetailsScreen({
    super.key,
    required this.boardID,
  });

  final BoardID boardID;

  void _onTapEdit(
      BuildContext context, WidgetRef ref, CollectorID connectedCollectorID) {
    ref.read(collectorConnectedToBoardProvider.notifier).state =
        connectedCollectorID;
    ref.read(selectedCollectorIdProvider.notifier).state = connectedCollectorID;
    context.pushNamed(
      AppRoute.updateBoard.name,
      pathParameters: {
        'boardId': boardID,
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(boardStreamProvider(boardID: boardID));
    return Scaffold(
      body: PaddedSafeArea(
          child: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: board.valueOrNull?.name ?? '',
            actions: [
              CommonEditIconButton(
                onPressed: () => _onTapEdit(
                    context, ref, board.valueOrNull?.collectorId ?? ','),
              )
            ],
          ),
          AsyncValueSliverWidget(
            value: board,
            data: (board) {
              // it's safe to assume that board won't be null
              // since reaching this page means we have a board
              return BoardDetailsScreenContents(board: board!);
            },
            loading: () => const CommonSliverListSkeleton(
              hasLeading: false,
              hasTrailing: false,
            ),
          )
        ],
      )),
    );
  }
}
