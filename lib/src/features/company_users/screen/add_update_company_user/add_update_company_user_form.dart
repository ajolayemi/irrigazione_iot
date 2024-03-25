import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';

class AddUpdateCompanyUserForm extends StatelessWidget {
  const AddUpdateCompanyUserForm({
    super.key,
    required this.companyUserId,
    required this.formType,
  });

  final CompanyUserID companyUserId;
  final GenericFormTypes formType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: CustomScrollView(
        slivers: [
          AppSliverBar(title: 'coming soon')
        ],
      ),),
    );
  }
}
