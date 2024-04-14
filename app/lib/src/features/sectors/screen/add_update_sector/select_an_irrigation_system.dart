import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/irrigation_enums.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/add_update_sector/responsive_select_screens_tile.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/padded_safe_area.dart';

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
                final irrigationSystemType = IrrigationSystem.values[index];
                return ResponsiveSelectScreensTile(
                  title: irrigationSystemType.uiName,
                  onTap: () {
                    Navigator.of(context).pop(irrigationSystemType.uiName);
                  },
                );
              },
              childCount: IrrigationSystem.values.length,
            ))
          ],
        ),
      ),
    );
  }
}
