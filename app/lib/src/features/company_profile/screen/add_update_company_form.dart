import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/enums/form_types.dart';
import 'add_update_company_controller.dart';
import 'add_update_company_form_content.dart';
import '../../company_users/model/company.dart';
import '../../../utils/async_value_ui.dart';
import '../../../widgets/padded_safe_area.dart';

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
