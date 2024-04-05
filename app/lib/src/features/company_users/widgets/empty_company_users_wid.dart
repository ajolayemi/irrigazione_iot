import 'package:flutter/material.dart';
import '../../../utils/extensions.dart';
import '../../../widgets/alert_dialogs.dart';
import '../../../widgets/empty_data_widget.dart';

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
