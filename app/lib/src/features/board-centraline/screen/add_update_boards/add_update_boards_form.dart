import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screen/add_update_boards/add_update_board_controller.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screen/add_update_boards/add_update_board_form_content.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';


class AddUpdateBoardsForm extends ConsumerWidget {
  const AddUpdateBoardsForm({
    super.key,
    required this.formType,
    this.boardID,
  });

  final String? boardID;
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
