import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screen/add_update_boards/add_update_board_form_content.dart';

class AddUpdateBoardsForm extends ConsumerWidget {
  const AddUpdateBoardsForm({
    super.key,
    required this.formType,
    this.boardID,
  });

  final BoardID? boardID;
  final GenericFormTypes formType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO add listener on state

    // TODO replace with normal state
    const isLoading = false;

    return PopScope(
      canPop: !isLoading,
      onPopInvoked: (didPop) {
        if (didPop) {
          debugPrint('User exited Board form');
        } else {
          debugPrint('User tried to exit Board form');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: AddUpdateBoardFormContent(
            formType: formType,
            boardID: boardID,
          ),
        ),
      ),
    );
  }
}
