import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company.dart';

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
    return Container();
  }
}
