import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/enums/roles.dart';
import '../../../config/routes/routes_enums.dart';
import 'more_page_item_list_tile.dart';
import '../../company_users/data/company_users_repository.dart';
import '../../../utils/extensions.dart';

class CompanyUsersMoreOptionItem extends ConsumerWidget {
  const CompanyUsersMoreOptionItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final hasPermission =
        ref.watch(companyUserRoleProvider).valueOrNull?.canAddNewUser ?? false;
    // Option to view and edit the list of users for the company
    // it's only available to admin, superuser, and owner
    return MorePageItemListTile(
      title: loc.companyUsersMenuTitle,
      onTap: hasPermission
          ? () => context.pushNamed(
                AppRoute.companyUsers.name,
              )
          : () {},
      leadingIcon: Icons.people,
    );
  }
}
