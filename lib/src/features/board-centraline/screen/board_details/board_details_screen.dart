import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/custom_edit_icon_button.dart';

class BoardDetailsScreen extends ConsumerWidget {
  const BoardDetailsScreen({
    super.key,
    required this.boardID,
  });

  final BoardID boardID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(boardStreamProvider(boardID: boardID));
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: board.valueOrNull?.name ?? '',
            actions: [
              CustomEditIconButton(
                onPressed: () =>
                    showNotImplementedAlertDialog(context: context),
              )
            ],
          ),
        ],
      )),
    );
  }
}
