import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/company_profile/screen/add_update_company_controller.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/widgets/responsive_sliver_form.dart';

class AddUpdateCompanyFormContent extends ConsumerStatefulWidget {
  const AddUpdateCompanyFormContent({
    super.key,
    this.companyID,
    required this.formType,
  });

  final CompanyID? companyID;
  final GenericFormTypes formType;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddUpdateCompanyFormContentsState();
}

class _AddUpdateCompanyFormContentsState
    extends ConsumerState<AddUpdateCompanyFormContent> with AppFormValidators {
  final _node = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();

  // field controllers
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _fiscalCodeController = TextEditingController();
  final _vatNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // form values
  String get _name => _nameController.text;
  String get _address => _addressController.text;
  String get _fiscalCode => _fiscalCodeController.text;
  String get _vatNumber => _vatNumberController.text;
  String get _email => _emailController.text;
  String get _phone => _phoneController.text;

  // field keys
  static const _nameFieldKey = Key('companyNameFieldKey');
  static const _addressFieldKey = Key('companyAddressFieldKey');
  static const _fiscalCodeFieldKey = Key('companyFiscalCodeFieldKey');
  static const _vatNumberFieldKey = Key('companyVatNumberFieldKey');
  static const _emailFieldKey = Key('companyEmailFieldKey');
  static const _phoneFieldKey = Key('companyPhoneFieldKey');

  // variable to track if user is updating
  bool get _isUpdating => widget.formType == GenericFormTypes.update;

  // variable to activate form validation only when form has been submitted
  var _submitted = false;

  // initial company data (will have value when user is updating)
  Company? _initialCompany;

  @override
  void initState() {
    if (_isUpdating && widget.companyID != null) {
      final company =
          ref.read(companyStreamProvider(widget.companyID!)).valueOrNull;
      _initialCompany = company;
      if (company != null) {
        _nameController.text = company.name;
        _addressController.text = company.registeredOfficeAddress;
        _fiscalCodeController.text = company.fiscalCode ?? '';
        _vatNumberController.text = company.vatNumber ?? '';
        _emailController.text = company.email;
        _phoneController.text = company.phoneNumber;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _fiscalCodeController.dispose();
    _vatNumberController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _node.dispose();
    super.dispose();
  }

  /// Validates the following form fields
  /// - name
  /// - address
  /// - phone
  void _nonEmptyFieldsEditingComplete(String value) {
    if (canSubmitNonEmptyFields(value: value)) {
      _node.nextFocus();
    }
  }

  /// Gets error text for non-empty fields, which are
  /// - name
  /// - address
  /// - phone
  String? _nonEmptyFieldsErrorText(String value) {
    if (!_submitted) return null;

    return context.getLocalizedErrorText(
      errorKey: getNonEmptyFieldsErrorKey(value: value),
    );
  }

  /// Validates email form field
  void _emailEditingComplete(String value) {
    if (canSubmitEmail(value: value)) {
      _node.nextFocus();
    }
  }

  /// Gets error text for email form field
  /// - email
  String? _emailErrorText(String value) {
    if (!_submitted) return null;

    return context.getLocalizedErrorText(
      errorKey: getEmailErrorKey(value: value),
    );
  }

  /// Validates form fields that are dependent on one another
  /// - fiscal code
  /// - vat number
  void _dependentFieldsEditingComplete() {
    if (canSubmitDependentFields(
      value1: _fiscalCode,
      value2: _vatNumber,
    )) {
      _node.nextFocus();
    }
  }

  /// Gets error text for dependent fields
  /// - fiscal code
  /// - vat number
  String? _dependentFieldsErrorText() {
    if (!_submitted) return null;

    final loc = context.loc;
    return context.getLocalizedDependentErrorText(
      field1Name: loc.companyFiscalCode,
      field2Name: loc.companyVatNumber,
      errorKey: getDependentFieldsErrorKey(
        value1: _fiscalCode,
        value2: _vatNumber,
      ),
    );
  }

  Future<void> _submit() async {
    _node.unfocus();
    setState(() => _submitted = true);

    if (_formKey.currentState!.validate()) {
      if (await context.showSaveUpdateDialog(
        isUpdating: _isUpdating,
        what: context.loc.nCompany(1),
      )) {
        final company = _initialCompany?.copyWith(
          name: _name,
          registeredOfficeAddress: _address,
          fiscalCode: _fiscalCode,
          vatNumber: _vatNumber,
          email: _email,
          phoneNumber: _phone,
          id: _initialCompany?.id,
        );

        bool success = false;
        if (_isUpdating) {
          success = await ref
              .read(addUpdateCompanyControllerProvider.notifier)
              .updateCompany(company);
        } else {
          success = await ref
              .read(addUpdateCompanyControllerProvider.notifier)
              .addCompany(company);
        }

        if (success) {
          _popScreen();
          return;
        }
        return;
      } else {
        debugPrint('Company form data is valid but user chose not to save');
      }
    }
  }

  void _popScreen() => context.popNavigator();

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final isLoading = ref.watch(addUpdateCompanyControllerProvider).isLoading;

    // TODO add company id field to form, it should not be modifiable
    // TODO and should be filled progressively when user is adding a new company

    return GestureDetector(
      onTap: _node.unfocus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                AppSliverBar(
                  title: _isUpdating
                      ? loc.updateCompanyPageTitle
                      : loc.addNewCompanyPageTitle,
                ),
                ResponsiveSliverForm(
                  node: _node,
                  formKey: _formKey,
                  children: [
                    FormTitleAndField(
                      fieldKey: _nameFieldKey,
                      fieldTitle: loc.companyName,
                      fieldController: _nameController,
                      fieldHintText: loc.companyNameHintText,
                      onEditingComplete: () =>
                          _nonEmptyFieldsEditingComplete(_name),
                      validator: (_) => _nonEmptyFieldsErrorText(_name),
                    ),
                    gapH16,
                    FormTitleAndField(
                      fieldKey: _addressFieldKey,
                      fieldTitle: loc.companyRegisteredAddress,
                      fieldController: _addressController,
                      fieldHintText: loc.companyRegisteredAddressHintText,
                      onEditingComplete: () =>
                          _nonEmptyFieldsEditingComplete(_address),
                      validator: (_) => _nonEmptyFieldsErrorText(_address),
                    ),
                    gapH16,
                    FormTitleAndField(
                      fieldKey: _fiscalCodeFieldKey,
                      fieldTitle: loc.companyFiscalCode,
                      fieldController: _fiscalCodeController,
                      fieldHintText: loc.companyFiscalCodeHintText,
                      autovalidateMode: AutovalidateMode.always,
                      onEditingComplete: _dependentFieldsEditingComplete,
                      validator: (_) => _dependentFieldsErrorText(),
                    ),
                    gapH16,
                    FormTitleAndField(
                      fieldKey: _vatNumberFieldKey,
                      fieldTitle: loc.companyVatNumber,
                      fieldController: _vatNumberController,
                      fieldHintText: loc.companyVatNumberHintText,
                      autovalidateMode: AutovalidateMode.always,
                      onEditingComplete: _dependentFieldsEditingComplete,
                      validator: (_) => _dependentFieldsErrorText(),
                    ),
                    gapH16,
                    FormTitleAndField(
                      fieldKey: _emailFieldKey,
                      fieldTitle: loc.companyEmail,
                      fieldController: _emailController,
                      fieldHintText: loc.companyEmailHintText,
                      onEditingComplete: () => _emailEditingComplete(_email),
                      validator: (_) => _emailErrorText(_email),
                    ),
                    gapH16,
                    FormTitleAndField(
                      fieldKey: _phoneFieldKey,
                      fieldTitle: loc.companyPhone,
                      fieldController: _phoneController,
                      fieldHintText: loc.companyPhoneHintText,
                      onEditingComplete: () =>
                          _nonEmptyFieldsEditingComplete(_phone),
                      validator: (_) => _nonEmptyFieldsErrorText(_phone),
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
