import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_sliver_connect_something_to.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_data_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_radio_list_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/sliver_adaptive_circular_indicator.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';

class ConnectSectorToSensorScreen extends ConsumerStatefulWidget {
  const ConnectSectorToSensorScreen({
    super.key,
    required this.selectedSector,
  });

  /// The previous value that was selected during the previous navigation
  /// to the sensor form screen.
  final RadioButtonItem selectedSector;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConnectSectorToSensorScreenState();
}

class _ConnectSectorToSensorScreenState
    extends ConsumerState<ConnectSectorToSensorScreen> {
  late RadioButtonItem _selectedValue;

  @override
  void initState() {
    _selectedValue = widget.selectedSector;
    super.initState();
  }

  void _onTapAdd(BuildContext context) =>
      context.pushNamed(AppRoute.addSector.name);

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;

    final sectors = ref.watch(sectorListStreamProvider);
    return CustomSliverConnectSomethingTo(
      title: loc.sensorConnectSectorPageTitle,
      actions: [
        CommonAddIconButton(
          onPressed: () => _onTapAdd(context),
        ),
      ],
      child: AsyncValueSliverWidget<List<Sector?>>(
        value: sectors,
        data: (data) {
          if (data.isEmpty) {
            return SliverEmptyDataWidget(
              message: loc.emptyDataPlaceholder(
                loc.nSectors(1),
              ),
              buttonText: loc.addNewButtonLabel,
              onPressed: () => _onTapAdd(context),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final sector = data[index]!;
                return ResponsiveRadioListTile(
                  title: sector.name,
                  value: RadioButtonItem(
                    value: sector.id,
                    label: sector.name,
                  ),
                  groupValue: _selectedValue,
                  onChanged: (value) => setState(
                    () {
                      _selectedValue = _selectedValue.copyWith(
                        value: value?.value,
                        label: value?.label,
                      );
                    },
                  ),
                );
              },
              childCount: data.length,
            ),
          );
        },
        loading: () => const SliverAdaptiveCircularIndicator(),
      ),
      onCTAPressed: () => context.popNavigator<RadioButtonItem>(_selectedValue),
    );
  }
}
