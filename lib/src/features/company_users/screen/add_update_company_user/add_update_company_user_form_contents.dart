import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';

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

  @override
  Widget build(BuildContext context) {
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
              ],
            ),
          )
        ],
      ),
    );
  }
}