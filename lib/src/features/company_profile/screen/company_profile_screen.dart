import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/features/company_profile/screen/company_profile_screen_contents.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company.dart';

class CompanyProfileScreen extends StatelessWidget {
  const CompanyProfileScreen({
    super.key,
    required this.companyID,
  });

  final CompanyID companyID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CompanyProfileScreenContents(
          companyID: companyID,
        ),
      ),
    );
  }
}
