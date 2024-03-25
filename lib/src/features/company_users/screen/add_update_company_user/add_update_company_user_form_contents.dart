import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/widgets/responsive_sliver_form.dart';

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

  CompanyUser? _initialCompanyUser;

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
    if (_submitted) return null;

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
    if (_submitted) return null;

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
        print('form is valid and user chose to submit');
      } else {
        print('form is valid but user chose not to submit');
      }
    } else {
      print('form is invalid');
    }
  }

  void _popScreen() => context.popNavigator();

  @override
  Widget build(BuildContext context) {
    // TODO replace with right state
    final isLoading = false;
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
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
