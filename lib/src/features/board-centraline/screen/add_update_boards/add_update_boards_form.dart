import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board.dart';

class AddUpdateBoardsForm extends ConsumerStatefulWidget {
  const AddUpdateBoardsForm({
    super.key,
    required this.formType,
    this.boardID,
  });

  final BoardID? boardID;
  final GenericFormTypes formType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddUpdateBoardsFormState();
}

class _AddUpdateBoardsFormState extends ConsumerState<AddUpdateBoardsForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
