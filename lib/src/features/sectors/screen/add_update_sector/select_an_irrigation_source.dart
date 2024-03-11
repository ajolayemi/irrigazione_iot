import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/enums/irrigation_enums.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/add_update_sector/responsive_select_screens_tile.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';

class SelectAnIrrigationSource extends StatelessWidget {
  const SelectAnIrrigationSource({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: context.loc.selectAnIrrigationSource,
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