import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/enums/form_types.dart';
import 'add_update_company_user_controller.dart';
import 'add_update_company_user_form_contents.dart';
import '../../../../utils/async_value_ui.dart';
import '../../../../widgets/padded_safe_area.dart';

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
        body: PaddedSafeArea(
          child: AddUpdateCompanyUserFormContents(
            companyUserId: companyUserId,
            formType: formType,
          ),
        ),
      ),
    );
  }
}