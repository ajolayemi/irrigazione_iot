import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/enums/form_types.dart';
import '../../models/board.dart';
import 'add_update_board_controller.dart';
import 'add_update_board_form_content.dart';
import '../../../../utils/async_value_ui.dart';
import '../../../../widgets/padded_safe_area.dart';

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
    ref.listen(addUpdateBoardControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));

    final isLoading = ref.watch(addUpdateBoardControllerProvider).isLoading;

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
        body: PaddedSafeArea(
          child: AddUpdateBoardFormContent(
            formType: formType,
            boardID: boardID,
          ),
        ),
      ),
    );
  }
}
