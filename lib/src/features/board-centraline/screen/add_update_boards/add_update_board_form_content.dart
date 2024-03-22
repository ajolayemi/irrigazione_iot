import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';

class AddUpdateBoardFormContent extends ConsumerStatefulWidget {
  const AddUpdateBoardFormContent({
    super.key,
    required this.formType,
    this.boardID,
  });

  final BoardID? boardID;
  final GenericFormTypes formType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddUpdateBoardFormContentState();
}

class _AddUpdateBoardFormContentState
    extends ConsumerState<AddUpdateBoardFormContent> {
  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final isUpdating = widget.formType.isUpdating;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: isUpdating
                  ? loc.updateBoardPageTitle
                  : loc.addNewBoardPageTitle,
            ),
          ],
        ))
      ],
    );
  }
}
