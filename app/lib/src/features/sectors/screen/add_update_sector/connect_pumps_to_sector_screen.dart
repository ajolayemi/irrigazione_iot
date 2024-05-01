import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/empty_pump_widget.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_sliver_connect_something_to.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_radio_list_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/sliver_adaptive_circular_indicator.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class ConnectPumpToSector extends ConsumerStatefulWidget {
  const ConnectPumpToSector(
      {super.key,
      this.selectedPumpId,
      this.selectedPumpName,
      this.pumpIdPreviouslyConnectedToSector});

  /// When the user navigates to this screen from the sector details screen,
  /// the pump that was connected to the sector is passed as the selected pump.
  /// This is done so that the user can see the pump that is already connected
  /// to the sector.
  final String? pumpIdPreviouslyConnectedToSector;

  /// The id of the pump that was selected during the previous navigation
  final String? selectedPumpId;

  /// The name of the pump that was selected during the previous navigation
  final String? selectedPumpName;

  @override
  ConsumerState<ConnectPumpToSector> createState() =>
      _ConnectPumpToSectorState();
}

class _ConnectPumpToSectorState extends ConsumerState<ConnectPumpToSector> {
  late RadioButtonItem _selectedPump;

  @override
  void initState() {
    _selectedPump = RadioButtonItem(
      value: widget.selectedPumpId ?? '',
      label: widget.selectedPumpName ?? '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final availablePumps = ref.watch(availablePumpsFutureProvider(
      alreadyConnectedPumpId: widget.pumpIdPreviouslyConnectedToSector,
    ));
    final loc = context.loc;

    return CustomSliverConnectSomethingTo(
      title: loc.connectPumpToSectorPageTile,
      actions: [
        CommonAddIconButton(
          onPressed: () => context.pushNamed(
            AppRoute.addPump.name,
          ),
        ),
      ],
      child: AsyncValueSliverWidget(
        value: availablePumps,
        data: (pumps) {
          if (pumps == null || pumps.isEmpty) {
            return const EmptyPumpWidget();
          }

          // it should be save to assume that the pumps are not null here
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final pump = pumps[index];
                return ResponsiveRadioListTile(
                  title: pump.name,
                  value: RadioButtonItem(
                    value: pump.id,
                    label: pump.name,
                  ),
                  groupValue: _selectedPump,
                  onChanged: (val) => setState(() {
                    _selectedPump = _selectedPump.copyWith(
                      value: val?.value,
                      label: val?.label,
                    );
                  }),
                );
              },
              childCount: pumps.length,
            ),
          );
        },
        loading: () => const SliverAdaptiveCircularIndicator(),
      ),
      onCTAPressed: () => context.popNavigator(_selectedPump),
    );
  }
}
