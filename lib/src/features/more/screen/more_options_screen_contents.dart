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
import 'package:irrigazione_iot/src/features/user_companies/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/common_responsive_divider.dart';
import 'package:irrigazione_iot/src/widgets/sliver_logout_button.dart';

class MoreOptionsScreenContent extends ConsumerWidget {
  const MoreOptionsScreenContent({super.key});

  void _showNotImplemented(BuildContext context) {
    showNotImplementedAlertDialog(context: context);
  }



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldShowCompanyUser =
        ref.watch(companyUserRoleProvider).valueOrNull?.canAddNewUser ?? false;
    final uid = ref.watch(authRepositoryProvider).currentUser?.uid;
    final companyId = ref
        .watch(selectedCompanyRepositoryProvider)
        .loadSelectedCompanyId(uid!);
    final loc = context.loc;
    return Column(
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
                      onTap: () => context.pushNamed(
                          AppRoute.companyProfile.name,
                          pathParameters: {
                            'companyID': companyId ?? '',
                          }),
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
        const SliverLogoutButton(),
        gapH32,
      ],
    );
  }
}
