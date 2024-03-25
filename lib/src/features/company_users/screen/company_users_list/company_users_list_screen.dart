import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/features/company_users/screen/company_users_list/company_users_list_screen_contents.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/common_add_icon_button.dart';

class CompanyUsersListScreen extends StatelessWidget {
  const CompanyUsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: loc.companyUsersMenuTitle,
            actions: [
              CommonAddIconButton(
                onPressed: () => showNotImplementedAlertDialog(
                  context: context,
                ),
              )
            ],
          ),
          const CompanyUsersListScreenContents(),
        ],
      )),
    );
  }
}
