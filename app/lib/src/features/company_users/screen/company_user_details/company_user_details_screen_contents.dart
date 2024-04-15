import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user.dart';
import 'package:irrigazione_iot/src/utils/date_formatter.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/widgets/responsive_details_card.dart';

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
              subtitle: user.createdAt == null
                  ? 'N/A'
                  : dateFormatter.format(user.createdAt!),
            ),
          ),
          ResponsiveDetailsCard(
            child: DetailTileWidget(
              title: loc.companyUserLastUpdated,
              subtitle: user.updatedAt == null
                  ? "N/A"
                  : dateFormatter.format(user.updatedAt!),
            ),
          ),
        ],
      ),
    );
  }
}
