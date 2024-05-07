import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/model/app_user.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_center.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';

class UserProfileScreenContents extends ConsumerWidget {
  const UserProfileScreenContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // It's safe to assume that a user will be found here
    final currentUser = ref.watch(authRepositoryProvider).currentUser!;
    final loc = context.loc;
    return ResponsiveSliverCenter(
        child: Column(
      children: [
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.userProfileDetailsName,
            subtitle: currentUser.fullName,
          ),
        ),
        gapH8,
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.userProfileDetailsEmail,
            subtitle: currentUser.email,
          ),
        ),
        gapH8,
        Consumer(
          builder: (context, ref, child) {
            final companyId = ref
                .watch(selectedCompanyRepositoryProvider)
                .loadSelectedCompanyId(currentUser.uid);
            final company =
                ref.watch(companyStreamProvider(companyId ?? '')).valueOrNull;
            return ResponsiveDetailsCard(
              child: DetailTileWidget(
                title: loc.userProfileDetailsCurrentCompany,
                subtitle: company?.name ?? '',
              ),
            );
          },
        )
      ],
    ));
  }
}
