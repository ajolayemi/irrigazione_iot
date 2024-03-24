import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company.dart';

class CompanyProfileScreen extends ConsumerWidget {
  const CompanyProfileScreen({
    super.key,
    required this.companyID,
  });

  final CompanyID companyID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
