import 'package:flutter/widgets.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/pumps_switched_on_list.dart';

class DashboardScreenContents extends StatelessWidget {
  const DashboardScreenContents({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverList(
      delegate: SliverChildListDelegate.fixed([
       PumpsSwitchedOnList()
      ]),
    );
  }
}
