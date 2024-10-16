import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/role_management/data/role_management_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/screens/company_user_details/company_user_details_screen_contents.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_edit_icon_button.dart';

class CompanyUserDetailsScreen extends ConsumerWidget {
  const CompanyUserDetailsScreen({
    super.key,
    required this.companyUserId,
  });

  final String companyUserId;

  void _onTap(BuildContext context) {
    final params = PathParameters(id: companyUserId).toJson();
    context.pushNamed(
      AppRoute.updateCompanyUser.name,
      pathParameters: params,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyUser = ref.watch(
      companyUserStreamProvider(companyUserId: companyUserId),
    );
    final loggedInUser = ref.watch(authRepositoryProvider).currentUser;
    final isMe = loggedInUser != null &&
        loggedInUser.email == companyUser.valueOrNull?.email;
    final userCanEdit =
        ref.watch(userCanEditStreamProvider).valueOrNull ?? false;
    final loc = context.loc;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: isMe ? loc.me : companyUser.valueOrNull?.fullName ?? '',
              actions: [
                CommonEditIconButton(
                  onPressed: () => _onTap(context),
                  alternateIsVisible: userCanEdit && !isMe,
                ),
              ],
            ),
            AsyncValueSliverWidget(
              value: companyUser,
              loading: () => const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              data: (user) {
                return CompanyUserDetailsScreenContents(user: user!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
