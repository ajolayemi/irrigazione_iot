import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/widgets/company_user_list_tile.dart';
import 'package:irrigazione_iot/src/features/company_users/widgets/empty_company_users_wid.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_sliver_list_skeleton.dart';

class CompanyUsersListScreenContents extends ConsumerWidget {
  const CompanyUsersListScreenContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyUsers = ref.watch(usersAssociatedWithCompanyStreamProvider);
    return AsyncValueSliverWidget(
      value: companyUsers,
      data: (users) {
        if (users.isEmpty) {
          return const EmptyCompanyUsers();
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final user = users[index]!;
              return CompanyUserListTile(user: user);
            },
            childCount: users.length,
          ),
        );
      },
      loading: () => const CommonSliverListSkeleton(
        hasLeading: false,
      ),
    );
  }
}
