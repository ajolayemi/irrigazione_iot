import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company.dart';

class AddUpdateCompanyFormContent extends ConsumerStatefulWidget {
  const AddUpdateCompanyFormContent({
    super.key,
    required this.companyID,
    required this.formType,
  });

  final CompanyID companyID;
  final GenericFormTypes formType;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddUpdateCompanyFormContentsState();
}

class _AddUpdateCompanyFormContentsState
    extends ConsumerState<AddUpdateCompanyFormContent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector();
  }
}
