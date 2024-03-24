import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/more/widgets/more_page_item_list_tile.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/common_responsive_divider.dart';

class MoreOptionsScreen extends ConsumerWidget {
  const MoreOptionsScreen({super.key});

  void _showNotImplemented(BuildContext context) {
    showNotImplementedAlertDialog(context: context);
  }

  Future<bool> _showSignOutDialog(BuildContext context) async {
    final loc = context.loc;
    return await showAlertDialog(
            context: context,
            title: loc.logOutAlertDialogTitle,
            content: loc.logOutAlertDialogContent,
            cancelActionText: loc.alertDialogCancel,
            defaultActionText: loc.logOutAlertDialogConfirm) ??
        false;
  }

  void _signOut(BuildContext context, WidgetRef ref) async {
    if (await _showSignOutDialog(context)) {
      ref.read(authRepositoryProvider).signOut();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldShowCompanyUser =
        ref.watch(companyUserRoleProvider).valueOrNull?.canAddNewUser ?? false;
    final loc = context.loc;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                AppSliverBar(title: loc.morePageTitle),
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      MorePageItemListTile(
                        title: loc.iotBoardsMenuTitle,
                        onTap: () => context.pushNamed(
                          AppRoute.boards.name,
                        ),
                        leadingIcon: Icons.device_hub,
                      ),
                      const CommonResponsiveDivider(),
                      MorePageItemListTile(
                        title: loc.profilePageTitle,
                        onTap: () => context.pushNamed(
                          AppRoute.profile.name,
                        ),
                        leadingIcon: Icons.person,
                      ),
                      // Page to view the details of the company profile the user is currently
                      // working with
                      MorePageItemListTile(
                        title: loc.companyProfileMenuTitle,
                        onTap: () => _showNotImplemented(context),
                        leadingIcon: Icons.business,
                      ),
                      // Option to view and edit the list of users for the company
                      // it's only available to admin, superuser, and owner
                      if (shouldShowCompanyUser)
                        MorePageItemListTile(
                          title: loc.companyUsersMenuTitle,
                          onTap: () => _showNotImplemented(context),
                          leadingIcon: Icons.people,
                        ),
                      MorePageItemListTile(
                        title: loc.settingsMenuTitle,
                        onTap: () => _showNotImplemented(context),
                        leadingIcon: Icons.settings,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverCTAButton(
            text: loc.logOutButtonTitle,
            buttonType: ButtonType.secondary,
            onPressed: () => _signOut(context, ref),
          ),
          gapH32,
        ],
      )),
    );
  }
}
