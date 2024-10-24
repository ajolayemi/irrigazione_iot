import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_sliver_list_skeleton.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';


class CompanyProfileScreenContents extends ConsumerWidget {
  const CompanyProfileScreenContents({
    super.key,
    required this.companyID,
  });

  final String companyID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyDetails = ref.watch(companyStreamProvider(companyID));
    final loc = context.loc;
    return AsyncValueSliverWidget(
        value: companyDetails,
        data: (companyData) {
          // It is safe to assume that a company will be found here
          final company = companyData!;
          return SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                ResponsiveDetailsCard(
                  child: DetailTileWidget(
                    title: loc.nameFormFieldTitle,
                    subtitle: company.name,
                  ),
                ),
                gapH8,
                ResponsiveDetailsCard(
                  child: DetailTileWidget(
                    title: loc.companyEmail,
                    subtitle: company.email,
                  ),
                ),
                gapH8,
                ResponsiveDetailsCard(
                  child: DetailTileWidget(
                    title: loc.companyPhone,
                    subtitle: company.phoneNumber,
                  ),
                ),
                gapH8,
                ResponsiveDetailsCard(
                  child: DetailTileWidget(
                    title: loc.companyRegisteredAddress,
                    subtitle: company.registeredOfficeAddress,
                  ),
                ),
                gapH8,
                ResponsiveDetailsCard(
                  child: DetailTileWidget(
                    title: loc.companyVatNumber,
                    subtitle: company.vatNumber,
                  ),
                ),
                gapH8,
                ResponsiveDetailsCard(
                  child: DetailTileWidget(
                    title: loc.companyFiscalCode,
                    subtitle: company.fiscalCode,
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const CommonSliverListSkeleton(
              hasLeading: false,
              hasTrailing: false,
            ));
  }
}
