import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company.dart';
import 'package:irrigazione_iot/src/features/company_users/screen/user_company_list/user_companies_controller.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_sliver_list_skeleton.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_center.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class UserCompaniesListScreen extends ConsumerStatefulWidget {
  const UserCompaniesListScreen({super.key});

  @override
  ConsumerState<UserCompaniesListScreen> createState() =>
      _UserCompaniesListScreenState();
}

class _UserCompaniesListScreenState
    extends ConsumerState<UserCompaniesListScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(
      userCompaniesControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final userCompanies = ref.watch(userCompaniesStreamProvider);

    if (userCompanies.hasValue && userCompanies.value!.isEmpty) {
      return const EmptyUserCompanyWidget();
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: context.loc.chooseCompany,
          ),
          AsyncValueSliverWidget<List<Company>>(
            value: userCompanies,
            loading: () => const CommonSliverListSkeleton(
              hasSubtitle: false,
            ),
            data: (userCompanies) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final company = userCompanies[index];
                    return ResponsiveCenter(
                      maxContentWidth: Breakpoint.tablet,
                      child: InkWell(
                        onTap: () {
                          ref
                              .read(userCompaniesControllerProvider.notifier)
                              .updateTappedCompanyId(company.id);
                          context.goNamed(AppRoute.home.name);
                        },
                        child: ListTile(
                          // leading: CompanyLogo(
                          //   imageUrl: company.imageUrl,
                          // ),
                          title: Text(
                            company.name,
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: userCompanies.length,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class EmptyUserCompanyWidget extends ConsumerWidget {
  const EmptyUserCompanyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return Scaffold(
      body: ResponsiveCenter(
        padding: const EdgeInsets.all(Sizes.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              context.loc.noCompanyFoundForUser(user?.name ?? 'N/A'),
              style: context.textTheme.headlineMedium,
              //textAlign: TextAlign.center,
            ),
            gapH48,
            CTAButton(
              buttonType: ButtonType.secondary,
              onPressed: () => ref.read(authRepositoryProvider).signOut(),
              text: context.loc.logInWithAnotherAccount,
            ), // todo replace the onPressed func with the right controller
          ],
        ),
      ),
    );
  }
}
