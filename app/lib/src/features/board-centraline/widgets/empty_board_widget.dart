import 'package:flutter/material.dart';
import '../../../utils/extensions.dart';
import '../../../widgets/alert_dialogs.dart';
import '../../../widgets/empty_data_widget.dart';

class EmptyBoardWidget extends StatelessWidget {
  const EmptyBoardWidget({
    super.key,
    this.alternativeMessage,
  });

  final String? alternativeMessage;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return SliverFillRemaining(
      child: EmptyDataWidget(
        message: alternativeMessage ?? loc.emptyDataPlaceholder(loc.nBoards(1)),
        buttonText: loc.addNewButtonLabel,
        onPressed: () => showNotImplementedAlertDialog(context: context),
      ),
    );
  }
}
