import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/models/company_user.dart';
import 'package:irrigazione_iot/src/features/company_users/screens/add_update_company_user/add_update_company_user_controller.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_form_suffix_icon.dart';
import 'package:irrigazione_iot/src/shared/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_sliver_form.dart';
import 'package:irrigazione_iot/src/utils/extensions/string_extensions.dart';


class AddUpdateCompanyUserFormContents extends ConsumerStatefulWidget {
  const AddUpdateCompanyUserFormContents({
    super.key,
    this.companyUserId,
    required this.formType,
  });

  final String? companyUserId;
  final GenericFormTypes formType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddUpdateCompanyUserFormContentsState();
}

class _AddUpdateCompanyUserFormContentsState
    extends ConsumerState<AddUpdateCompanyUserFormContents>
    with AppFormValidators {
  final _node = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();

  var _submitted = false;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _roleController = TextEditingController();

  String get _fullName => _fullNameController.text;
  String get _email => _emailController.text;
  String get _role => _roleController.text;

  // field keys
  static const _nameFieldKey = Key('companyUserFullNameField');
  static const _emailFieldKey = Key('companyUserEmailField');
  static const _roleFieldKey = Key('companyUserRoleField');

  bool get _isUpdating => widget.formType == GenericFormTypes.update;

  CompanyUser? _initialCompanyUser = const CompanyUser.empty();

  @override
  void initState() {
    if (_isUpdating && widget.companyUserId != null) {
      final user = ref
          .read(companyUserStreamProvider(companyUserId: widget.companyUserId!))
          .valueOrNull;
      if (user != null) {
        _initialCompanyUser = user;
        _fullNameController.text = user.fullName;
        _emailController.text = user.email;
        _roleController.text = user.role.name;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _node.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  /// for
  /// - fullName field
  /// - role field
  void _nonEmptyFieldsEditingComplete(String value) {
    if (canSubmitNonEmptyFields(value: value)) {
      _node.nextFocus();
    }
  }

  /// for
  /// - email field
  /// - role field
  String? _nonEmptyFieldsErrorText(String value) {
    if (!_submitted) return null;

    return context.getLocalizedErrorText(
      errorKey: getNonEmptyFieldsErrorKey(value: value),
    );
  }

  void _emailFieldEditingComplete(
    String value,
    List<String?> existingEmails,
  ) {
    if (canSubmitEmail(
      value: value,
      initialValue: _initialCompanyUser?.email,
      mailsToCompareAgainst: existingEmails,
    )) {
      _node.nextFocus();
    }
  }

  String? _emailFieldErrorText(
    String value,
    List<String?> existingEmails,
  ) {
    if (!_submitted) return null;

    return context.getLocalizedErrorText(
      errorKey: getEmailErrorKey(
        value: value,
        initialValue: _initialCompanyUser?.email,
        mailsToCompareAgainst: existingEmails,
      ),
    );
  }

  Future<void> _submit() async {
    _node.unfocus();
    setState(() => _submitted = true);

    if (_formKey.currentState!.validate()) {
      if (await context.showSaveUpdateDialog(
        isUpdating: _isUpdating,
        what: context.loc.nCompanyUsers(1),
      )) {
        final companyUser = _initialCompanyUser?.copyWith(
          fullName: _fullName,
          email: _email,
          role: _role.toCompanyUserRoles,
          companyId:
              _initialCompanyUser?.companyId, // auto filled by service layer
          createdAt: _initialCompanyUser?.createdAt ?? DateTime.now(),
          updatedAt: DateTime.now(),
        );

        bool success = false;

        if (_isUpdating) {
          success = await ref
              .read(addUpdateCompanyUserControllerProvider.notifier)
              .updateUserInCompany(companyUser);
        } else {
          success = await ref
              .read(addUpdateCompanyUserControllerProvider.notifier)
              .addUserToCompany(companyUser);
        }

        if (success) {
          _popScreen();
          return;
        }
        return;
      } else {
        debugPrint('form is valid but user chose not to submit');
      }
    } else {
      debugPrint('form is invalid');
    }
  }

  void _popScreen() => context.popNavigator();

  void _onTapAssignRole() async {
    final role = await context.showAssignRoleDialog(_role);
    if (role != null) {
      _roleController.text = role.label;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(addUpdateCompanyUserControllerProvider).isLoading;
    final loc = context.loc;
    return GestureDetector(
      onTap: () => _node.unfocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                AppSliverBar(
                  title: _isUpdating
                      ? loc.updateCompanyUserPageTitle
                      : loc.addNewCompanyUserPageTitle,
                ),
                ResponsiveSliverForm(
                  node: _node,
                  formKey: _formKey,
                  children: [
                    FormTitleAndField(
                      fieldKey: _nameFieldKey,
                      fieldTitle: loc.companyUserFullName,
                      fieldHintText: loc.companyUserFullNameHintTest,
                      fieldController: _fullNameController,
                      onEditingComplete: () =>
                          _nonEmptyFieldsEditingComplete(_fullName),
                      validator: (_) => _nonEmptyFieldsErrorText(_fullName),
                    ),
                    gapH16,
                    Consumer(
                      builder: (context, ref, child) {
                        final existingMails = isLoading
                            ? <String?>[]
                            : ref
                                    .watch(
                                        emailsAssociatedWithCompanyStreamProvider)
                                    .valueOrNull ??
                                [];
                        return FormTitleAndField(
                          fieldKey: _emailFieldKey,
                          fieldTitle: loc.companyUserEmail,
                          fieldHintText: loc.companyUserEmailHintText,
                          fieldController: _emailController,
                          onEditingComplete: () =>
                              _emailFieldEditingComplete(_email, existingMails),
                          validator: (_) =>
                              _emailFieldErrorText(_email, existingMails),
                        );
                      },
                    ),
                    gapH16,
                    FormTitleAndField(
                      fieldKey: _roleFieldKey,
                      fieldTitle: loc.companyUserRole,
                      fieldHintText: loc.companyUserRoleHintText,
                      fieldController: _roleController,
                      onTap: _onTapAssignRole,
                      validator: (_) => _nonEmptyFieldsErrorText(_role),
                      onEditingComplete: () =>
                          _nonEmptyFieldsEditingComplete(_role),
                      canRequestFocus: false,
                      suffixIcon: CommonFormSuffixIcon(
                        onPressed: _onTapAssignRole,
                      ),
                    ),
                    gapH32,
                  ],
                ),
              ],
            ),
          ),
          gapH16,
          SliverCTAButton(
            isLoading: isLoading,
            text: _isUpdating
                ? loc.genericUpdateButtonLabel
                : loc.genericSaveButtonLabel,
            buttonType: ButtonType.primary,
            onPressed: _submit,
          ),
          gapH32,
        ],
      ),
    );
  }
}
