import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/app_sizes.dart';
import '../../authentication/data/auth_repository.dart';
import '../../authentication/model/app_user.dart';
import '../../company_users/data/company_repository.dart';
import '../../company_users/data/selected_company_repository.dart';
import '../../../utils/extensions.dart';
import '../../../widgets/details_tile_widget.dart';
import '../../../widgets/responsive_center.dart';
import '../../../widgets/responsive_details_card.dart';

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
            final company = ref.watch(companyStreamProvider(companyId ?? '')).valueOrNull;
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
