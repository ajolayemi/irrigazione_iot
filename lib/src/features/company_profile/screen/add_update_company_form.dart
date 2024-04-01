import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/company_profile/screen/add_update_company_controller.dart';
import 'package:irrigazione_iot/src/features/company_profile/screen/add_update_company_form_content.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/widgets/padded_safe_area.dart';

class AddUpdateCompanyForm extends ConsumerWidget {
  const AddUpdateCompanyForm({
    super.key,
    required this.companyID,
    required this.formType,
  });

  final CompanyID companyID;
  final GenericFormTypes formType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      addUpdateCompanyControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final isLoading = ref.watch(addUpdateCompanyControllerProvider).isLoading;
    return IgnorePointer(
      ignoring: isLoading,
      child: PopScope(
        canPop: !isLoading,
        onPopInvoked: (didPop) {
          if (didPop) {
            debugPrint('User exited Company form');
          } else {
            debugPrint('User tried to exit Company form');
          }
        },
        child: Scaffold(
          body: PaddedSafeArea(
            child: AddUpdateCompanyFormContent(
              companyID: companyID,
              formType: formType,
            ),
          ),
        ),
      ),
    );
  }
}
