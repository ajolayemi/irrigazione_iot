import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/empty_pump_widget.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/add_update_sector/connect_pumps_to_sector_controller.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_sliver_connect_something_to.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_radio_list_tile.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class ConnectPumpToSector extends ConsumerWidget {
  const ConnectPumpToSector({
    super.key,
    this.pumpIdAlreadyConnected,
  });

  final String? pumpIdAlreadyConnected;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availablePumps = ref.watch(availablePumpsFutureProvider(
      alreadyConnectedPumpId: pumpIdAlreadyConnected,
    ));
    final selectedPumpId = ref.watch(selectPumpRadioButtonProvider);
    final loc = context.loc;

    return CustomSliverConnectSomethingTo(
      title: loc.connectPumpsToSectorPageTile,
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
                  title: Text(pump.name),
                  value: RadioButtonItem(
                    value: pump.id,
                    label: pump.name,
                  ),
                  groupValue: RadioButtonItem(
                    value: selectedPumpId?.value ?? '',
                    label: selectedPumpId?.label ?? '',
                  ),
                  onChanged: (val) => ref
                      .read(connectPumpsToSectorControllerProvider.notifier)
                      .handleSelection(val),
                );
              },
              childCount: pumps.length,
            ),
          );
        },
        loading: () => const SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      onCTAPressed: () => context.popNavigator(selectedPumpId),
    );
  }
}
