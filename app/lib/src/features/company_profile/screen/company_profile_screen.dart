import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/enums/roles.dart';
import '../../../config/routes/routes_enums.dart';
import 'company_profile_screen_contents.dart';
import '../../company_users/data/company_users_repository.dart';
import '../../company_users/model/company.dart';
import '../../../utils/extensions.dart';
import '../../../widgets/app_sliver_bar.dart';
import '../../../widgets/common_edit_icon_button.dart';
import '../../../widgets/padded_safe_area.dart';

class CompanyProfileScreen extends ConsumerWidget {
  const CompanyProfileScreen({
    super.key,
    required this.companyID,
  });

  final CompanyID companyID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return Scaffold(
      body: PaddedSafeArea(
        child: CustomScrollView(
          slivers: [
            Consumer(
              builder: (context, ref, child) {
                final userCanEditCompanyProfile = ref
                        .watch(companyUserRoleProvider)
                        .valueOrNull
                        ?.canEditCompanyProfile ??
                    false;

                return AppSliverBar(
                  title: loc.companyProfileMenuTitle,
                  actions: [
                    CommonEditIconButton(
                      onPressed: () => context.pushNamed(
                        AppRoute.updateCompany.name,
                        pathParameters: {
                          'companyID': companyID,
                        },
                      ),
                      alternateIsVisible: userCanEditCompanyProfile,
                    )
                  ],
                );
              },
            ),
            CompanyProfileScreenContents(
              companyID: companyID,
            ),
          ],
        ),
      ),
    );
  }
}
