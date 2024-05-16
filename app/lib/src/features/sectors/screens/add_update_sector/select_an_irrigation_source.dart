import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/enums/irrigation_enums.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_sliver_connect_something_to.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_radio_list_tile.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class SelectAnIrrigationSource extends StatefulWidget {
  const SelectAnIrrigationSource({
    super.key,
    this.selectedIrrigationSource,
  });

  final String? selectedIrrigationSource;

  @override
  State<SelectAnIrrigationSource> createState() =>
      _SelectAnIrrigationSourceState();
}

class _SelectAnIrrigationSourceState extends State<SelectAnIrrigationSource> {
  final irrigationSources = IrrigationSource.values;
  late RadioButtonItem _selectedIrrigationSource;

  @override
  void initState() {
    _selectedIrrigationSource = RadioButtonItem(
      value: widget.selectedIrrigationSource ?? '',
      label: widget.selectedIrrigationSource ?? '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return CustomSliverConnectSomethingTo(
      title: loc.selectAnOption,
      onCTAPressed: () =>
          context.popNavigator<RadioButtonItem>(_selectedIrrigationSource),
      child: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final source = irrigationSources[index];
            return ResponsiveRadioListTile(
              value:
                  RadioButtonItem(value: source.uiName, label: source.uiName),
              groupValue: _selectedIrrigationSource,
              title: source.uiName,
              onChanged: (val) => setState(
                () {
                  _selectedIrrigationSource =
                      _selectedIrrigationSource.copyWith(
                    value: val?.value,
                    label: val?.label,
                  );
                },
              ),
            );
          },
          childCount: irrigationSources.length,
        ),
      ),
    );
  }
}
