import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/enums/irrigation_enums.dart';
import 'responsive_select_screens_tile.dart';
import '../../../../utils/extensions.dart';
import '../../../../widgets/app_sliver_bar.dart';
import '../../../../widgets/padded_safe_area.dart';

class SelectAnIrrigationSystem extends ConsumerWidget {
  const SelectAnIrrigationSystem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: PaddedSafeArea(
        child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: context.loc.selectAnIrrigationSystem,
              expandedHeight: 120.0,
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) {
                final irrigationSystemType = IrrigationSystemType.values[index];
                return ResponsiveSelectScreensTile(
                  title: irrigationSystemType.uiName,
                  onTap: () {
                    Navigator.of(context).pop(irrigationSystemType.uiName);
                  },
                );
              },
              childCount: IrrigationSystemType.values.length,
            ))
          ],
        ),
      ),
    );
  }
}
