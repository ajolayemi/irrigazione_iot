import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screen/board_details/board_details_screen_contents.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
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

  void _onTapEdit(
      BuildContext context, WidgetRef ref, Collector? connectedCollector) {
    ref.read(collectorConnectedToBoardProvider.notifier).state =
        connectedCollector?.id;
    ref.read(selectedCollectorProvider.notifier).state =
        connectedCollector == null
            ? null
            : RadioButtonItem(
                value: connectedCollector.id,
                label: connectedCollector.name,
              );
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
    final connectedCollector = ref
        .watch(collectorStreamProvider(board.valueOrNull?.collectorId ?? ''))
        .valueOrNull;
    return Scaffold(
      body: PaddedSafeArea(
          child: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: board.valueOrNull?.name ?? '',
            actions: [
              CommonEditIconButton(
                onPressed: () => _onTapEdit(
                  context,
                  ref,
                  connectedCollector,
                ),
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
