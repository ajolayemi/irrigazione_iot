import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';

class CompanyUserDetailsScreen extends ConsumerWidget {
  const CompanyUserDetailsScreen({
    super.key,
    required this.companyUserId,
  });

  final CompanyUserID companyUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [AppSliverBar(title: 'coming soon')],
        ),
      ),
    );
  }
}
