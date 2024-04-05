import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/routes/routes_enums.dart';
import '../../../constants/app_sizes.dart';
import '../../authentication/data/auth_repository.dart';
import '../widgets/company_users_item.dart';
import '../widgets/more_page_item_list_tile.dart';
import '../../company_users/data/selected_company_repository.dart';
import '../../../utils/extensions.dart';
import '../../../widgets/alert_dialogs.dart';
import '../../../widgets/app_sliver_bar.dart';
import '../../../widgets/sliver_logout_button.dart';

class MoreOptionsScreenContent extends ConsumerWidget {
  const MoreOptionsScreenContent({super.key});

  void _showNotImplemented(BuildContext context) {
    showNotImplementedAlertDialog(context: context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    MorePageItemListTile(
                      title: loc.profilePageTitle,
                      onTap: () => context.pushNamed(
                        AppRoute.profile.name,
                      ),
                      leadingIcon: Icons.person,
                    ),
                    // Page to view the details of the company profile the user is currently
                    // working with
                    Consumer(
                      builder: (context, ref, child) {
                        final uid =
                            ref.watch(authRepositoryProvider).currentUser?.uid;
                        final companyId = ref
                            .watch(selectedCompanyRepositoryProvider)
                            .loadSelectedCompanyId(uid!);
                        return MorePageItemListTile(
                          title: loc.companyProfileMenuTitle,
                          onTap: () => context.pushNamed(
                              AppRoute.companyProfile.name,
                              pathParameters: {
                                'companyID': companyId ?? '',
                              }),
                          leadingIcon: Icons.business,
                        );
                      },
                    ),
                    const CompanyUsersMoreOptionItem(),
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
