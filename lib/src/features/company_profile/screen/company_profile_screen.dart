import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/features/company_profile/screen/company_profile_screen_contents.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/common_edit_icon_button.dart';

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
      body: SafeArea(
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