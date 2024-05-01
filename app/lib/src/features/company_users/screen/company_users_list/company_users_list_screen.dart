import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/company_users/screen/company_users_list/company_users_list_screen_contents.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';

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
                onPressed: () => context.pushNamed(
                  AppRoute.addCompanyUser.name,
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
