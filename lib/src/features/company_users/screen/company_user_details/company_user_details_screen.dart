import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/screen/company_user_details/company_user_details_screen_contents.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/widgets/common_edit_icon_button.dart';

class CompanyUserDetailsScreen extends ConsumerWidget {
  const CompanyUserDetailsScreen({
    super.key,
    required this.companyUserId,
  });

  final String companyUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyUser = ref.watch(
      companyUserStreamProvider(companyUserId: companyUserId),
    );
    final loggedInUser = ref.watch(authRepositoryProvider).currentUser;
    final isMe = loggedInUser != null &&
        loggedInUser.email == companyUser.valueOrNull?.email;
    final loc = context.loc;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: isMe ? loc.me : companyUser.valueOrNull?.fullName ?? '',
              actions: [
                CommonEditIconButton(
                  onPressed: () => context.pushNamed(
                    AppRoute.updateCompanyUser.name,
                    pathParameters: {
                      'companyUserId': companyUserId,
                    },
                  ),
                  alternateIsVisible:
                      !isMe, // Hide the edit button if the user is viewing their own profile
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
