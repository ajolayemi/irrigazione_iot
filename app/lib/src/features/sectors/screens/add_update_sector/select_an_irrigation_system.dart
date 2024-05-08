import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/enums/irrigation_enums.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_sliver_connect_something_to.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_radio_list_tile.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class SelectAnIrrigationSystem extends StatefulWidget {
  const SelectAnIrrigationSystem({
    super.key,
    this.selectedIrrigationSystem,
  });

  final String? selectedIrrigationSystem;

  @override
  State<SelectAnIrrigationSystem> createState() =>
      _SelectAnIrrigationSystemState();
}

class _SelectAnIrrigationSystemState extends State<SelectAnIrrigationSystem> {
  late RadioButtonItem _selectedIrrigationSystem;

  @override
  void initState() {
    _selectedIrrigationSystem = RadioButtonItem(
      value: widget.selectedIrrigationSystem ?? '',
      label: widget.selectedIrrigationSystem ?? '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    const values = IrrigationSystem.values;
    return CustomSliverConnectSomethingTo(
      title: loc.selectAnOption,
      onCTAPressed: () => context.popNavigator(_selectedIrrigationSystem),
      child: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final irrigationSystemType = values[index];
            return ResponsiveRadioListTile(
              value: RadioButtonItem(
                value: irrigationSystemType.uiName,
                label: irrigationSystemType.uiName,
              ),
              groupValue: _selectedIrrigationSystem,
              title: irrigationSystemType.uiName,
              onChanged: (val) => setState(
                () {
                  _selectedIrrigationSystem =
                      _selectedIrrigationSystem.copyWith(
                    value: val?.value,
                    label: val?.label,
                  );
                },
              ),
            );
          },
          childCount: IrrigationSystem.values.length,
        ),
      ),
    );
  }
}
