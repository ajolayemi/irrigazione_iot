import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_data_widget.dart';

/// A widget to display when there are no company users
class EmptyCompanyUsers extends StatelessWidget {
  const EmptyCompanyUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;

    // TODO activate button here
    return SliverEmptyDataWidget(
      message: loc.noUsersConnectedWithCompany,
      buttonText: loc.addNewButtonLabel,
      onPressed: () => showNotImplementedAlertDialog(context: context),
    );
  }
}
