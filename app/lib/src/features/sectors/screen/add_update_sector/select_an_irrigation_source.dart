import 'package:flutter/material.dart';
import '../../../../config/enums/irrigation_enums.dart';
import 'responsive_select_screens_tile.dart';
import '../../../../utils/extensions.dart';
import '../../../../widgets/app_sliver_bar.dart';
import '../../../../widgets/padded_safe_area.dart';

class SelectAnIrrigationSource extends StatelessWidget {
  const SelectAnIrrigationSource({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaddedSafeArea(
        child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: context.loc.selectAnIrrigationSource,
              expandedHeight: 120.0,
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) {
                final irrigationSource = IrrigationSource.values[index];
                return ResponsiveSelectScreensTile(
                  title: irrigationSource.uiName,
                  onTap: () {
                    Navigator.of(context).pop(irrigationSource.uiName);
                  },
                );
              },
              childCount: IrrigationSource.values.length,
            ))
          ],
        ),
      ),
    );
  }
}
