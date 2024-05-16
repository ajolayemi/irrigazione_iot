import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/config/styles/app_styles.dart';
import 'package:irrigazione_iot/src/features/company_users/models/company_user.dart';
import 'package:irrigazione_iot/src/features/company_users/screens/company_user_details/dismiss_company_user_controller.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_tablet_responsive_center.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class CompanyUserListTileItem extends ConsumerWidget {
  const CompanyUserListTileItem({
    super.key,
    required this.companyUser,
    required this.isMe,
  });

  final CompanyUser companyUser;
  final bool isMe;

  void _onTap(BuildContext context) {
    final params = PathParameters(id: companyUser.id).toJson();
    context.pushNamed(
      AppRoute.companyUserDetails.name,
      pathParameters: params,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final isDeleting =
        ref.watch(dismissCompanyUserControllerProvider).isLoading;
    return CommonTabletResponsiveCenter(
        child: IgnorePointer(
      ignoring: isDeleting,
      child: InkWell(
        onTap: () => _onTap(context),
        child: ListTile(
          title: Text(isMe ? loc.me : companyUser.fullName),
          subtitle: Text(
            companyUser.email,
            style: context.commonSubtitleStyle,
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    ));
  }
}
