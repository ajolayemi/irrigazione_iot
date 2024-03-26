import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/company_users/screen/add_update_company_user/add_update_company_user_controller.dart';
import 'package:irrigazione_iot/src/features/company_users/screen/add_update_company_user/add_update_company_user_form_contents.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';

class AddUpdateCompanyUserForm extends ConsumerWidget {
  const AddUpdateCompanyUserForm({
    super.key,
    required this.companyUserId,
    required this.formType,
  });

  final String companyUserId;
  final GenericFormTypes formType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      addUpdateCompanyUserControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final  isLoading = ref.watch(addUpdateCompanyUserControllerProvider).isLoading;
    return PopScope(
      canPop: !isLoading,
      onPopInvoked: (didPop) {
        if (didPop) {
          debugPrint('User exited Company User form');
        } else {
          debugPrint('User tried to exit Company User form');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: AddUpdateCompanyUserFormContents(
            companyUserId: companyUserId,
            formType: formType,
          ),
        ),
      ),
    );
  }
}
