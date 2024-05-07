import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/company_profile/screens/company_profile_screen_contents.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_edit_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';



class CompanyProfileScreen extends ConsumerWidget {
  const CompanyProfileScreen({
    super.key,
    required this.companyID,
  });

  final String companyID;

  void _onTap(BuildContext context) {
    final params = PathParameters(id: companyID).toJson();
    context.pushNamed(
      AppRoute.updateCompany.name,
      pathParameters: params,
    );
  }

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
                      onPressed: () => _onTap(context),
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
