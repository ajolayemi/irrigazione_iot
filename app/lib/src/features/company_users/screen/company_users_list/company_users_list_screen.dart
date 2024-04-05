import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/routes_enums.dart';
import 'company_users_list_screen_contents.dart';
import '../../../../utils/extensions.dart';
import '../../../../widgets/app_sliver_bar.dart';
import '../../../../widgets/common_add_icon_button.dart';

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
