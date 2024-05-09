import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/role_management/data/role_management_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/models/company_user.dart';
import 'package:irrigazione_iot/src/features/company_users/screens/company_user_details/dismiss_company_user_controller.dart';
import 'package:irrigazione_iot/src/features/company_users/widgets/company_user_list_tile_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_dismissible.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class CompanyUserListTile extends ConsumerWidget {
  const CompanyUserListTile({
    super.key,
    required this.user,
  });

  final CompanyUser user;

  static Key companyUserListTileKey(CompanyUser user) =>
      Key('companyUserListTileKey_${user.id}');

  Future<bool> _dismissCompanyUser({
    required BuildContext context,
    required WidgetRef ref,
    required CompanyUser companyUser,
    required bool isMe,
  }) async {
    final loc = context.loc;
    if (isMe) {
      showAlertDialog(
        context: context,
        title: loc.cantDeleteYourselfDialogTitle,
      );
      return false;
    }
    if (await context.showDismissalDialog(
      alternateDialog: loc.companyUserDismissalDialogContent(
        companyUser.fullName,
      ),
      alternateTitle: loc.companyUserDismissalDialogTitle,
    )) {
      return await ref
          .read(dismissCompanyUserControllerProvider.notifier)
          .dismissCompanyUser(companyUser.id.toString());
    }
    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldIgnore =
        ref.watch(dismissCompanyUserControllerProvider).isLoading;
    final currentLoggedInUser = ref.watch(authRepositoryProvider).currentUser;
    final isMe =
        currentLoggedInUser != null && currentLoggedInUser.email == user.email;

    final canDelete =
        ref.watch(userCanDeleteStreamProvider).valueOrNull ?? false;

    return CustomDismissibleWidget(
      canDelete: canDelete,
      dismissibleKey: companyUserListTileKey(user),
      confirmDismiss: (_) async => await _dismissCompanyUser(
        context: context,
        ref: ref,
        companyUser: user,
        isMe: isMe,
      ),
      isDeleting: shouldIgnore,
      child: CompanyUserListTileItem(
        companyUser: user,
        isMe: isMe,
      ),
    );
  }
}
