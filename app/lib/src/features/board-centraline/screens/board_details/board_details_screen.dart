import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screens/board_details/board_details_screen_contents.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_edit_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_sliver_list_skeleton.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';

class BoardDetailsScreen extends ConsumerWidget {
  const BoardDetailsScreen({
    super.key,
    required this.boardID,
  });

  final String boardID;

  void _onTapEdit(BuildContext context) {
    final params = PathParameters(id: boardID).toJson();
    context.pushNamed(
      AppRoute.updateBoard.name,
      pathParameters: params,
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
                onPressed: () => _onTapEdit(context),
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
