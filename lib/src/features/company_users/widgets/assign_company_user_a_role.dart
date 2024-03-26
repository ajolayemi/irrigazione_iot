import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/add_update_sector/responsive_select_screens_tile.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';

class AssignCompanyUserARole extends StatelessWidget {
  const AssignCompanyUserARole({
    super.key,
    required this.currentRole,
  });

  final String currentRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          AppSliverBar(title: 'assign a role'),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final role = CompanyUserRoles.values[index];
              return ResponsiveSelectScreensTile(
                title: role.name,
                onTap: () => context.popNavigator(
                  role.name,
                ),
              );
            }, childCount: CompanyUserRoles.values.length),
          ),
        ],
      )),
    );
  }
}
