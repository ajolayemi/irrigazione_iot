import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

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
      print('got here');
    }
  }

  void _popScreen() => context.popNavigator();

  @override
  Widget build(BuildContext context) {
    return GestureDetector();
  }
}
