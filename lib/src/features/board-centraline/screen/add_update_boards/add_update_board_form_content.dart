import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }
}
