import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/company_user.dart';
import '../../../../utils/date_formatter.dart';
import '../../../../utils/extensions.dart';
import '../../../../widgets/details_tile_widget.dart';
import '../../../../widgets/responsive_details_card.dart';

class CompanyUserDetailsScreenContents extends ConsumerWidget {
  const CompanyUserDetailsScreenContents({
    super.key,
    required this.user,
  });

  final CompanyUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormatter = ref.watch(dateFormatWithTimeProvider);
    final loc = context.loc;
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          ResponsiveDetailsCard(
            child: DetailTileWidget(
              title: loc.companyUserEmail,
              subtitle: user.email,
            ),
          ),
          ResponsiveDetailsCard(
            child: DetailTileWidget(
              title: loc.companyUserAssignedRoleForDetails,
              subtitle: user.role.name,
            ),
          ),
          ResponsiveDetailsCard(
            child: DetailTileWidget(
              title: loc.companyUserAddedOn,
              subtitle: dateFormatter.format(user.createdAt),
            ),
          ),
          ResponsiveDetailsCard(
            child: DetailTileWidget(
              title: loc.companyUserLastUpdated,
              subtitle: dateFormatter.format(user.updatedAt),
            ),
          ),
        ],
      ),
    );
  }
}
