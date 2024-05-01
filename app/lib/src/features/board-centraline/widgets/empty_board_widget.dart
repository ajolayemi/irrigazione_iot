import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_data_widget.dart';

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
