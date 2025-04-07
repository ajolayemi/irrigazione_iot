import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/pumps/pumps_switched_on_list.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/sectors/sectors_switched_on_list.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class DashboardScreenContents extends StatelessWidget {
  const DashboardScreenContents({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          Text(
            loc.welcome(userName),
            style: textTheme.titleLarge?.copyWith(
              color: Colors.black,
            ),
          ),
          gapH32,
          const PumpsSwitchedOnList(),
          gapH32,
          const SectorsSwitchedOnList(),
          gapH64,
        ],
      ),
    );
  }
}
