import 'package:flutter/widgets.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/pumps/pumps_switched_on_list.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/sectors/sectors_switched_on_list.dart';

class DashboardScreenContents extends StatelessWidget {
  const DashboardScreenContents({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverList(
      delegate: SliverChildListDelegate.fixed([
        PumpsSwitchedOnList(),
        gapH32,
        SectorsSwitchedOnList(),
        gapH64,
      ]),
    );
  }
}
