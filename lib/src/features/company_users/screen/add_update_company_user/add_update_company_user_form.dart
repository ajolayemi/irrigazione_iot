import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/company_users/screen/add_update_company_user/add_update_company_user_form_contents.dart';

class AddUpdateCompanyUserForm extends StatelessWidget {
  const AddUpdateCompanyUserForm({
    super.key,
    required this.companyUserId,
    required this.formType,
  });

  final String companyUserId;
  final GenericFormTypes formType;

  @override
  Widget build(BuildContext context) {
    // TODO add listener to loading state when saving form
    // TODO replace with right state
    const isLoading = false;
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
