import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/empty_pump_widget.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/add_update_sector/connect_pumps_to_sector_controller.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_return_type.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_bar_icon_buttons.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';
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
    final canEdit = ref.watch(companyUserRoleProvider).valueOrNull?.canEdit;
    final availablePumps = ref.watch(availablePumpsFutureProvider(
      alreadyConnectedPumpId: pumpIdAlreadyConnected,
    ));
    final selectedPumpId = ref.watch(selectPumpRadioButtonProvider);
    final loc = context.loc;
    return Scaffold(
      body: PaddedSafeArea(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p12),
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  AppSliverBar(
                    title: loc.connectPumpsToSectorPageTile,
                    actions: [
                      AppBarIconButton(
                        onPressed: () =>
                            context.pushNamed(AppRoute.addPump.name),
                        icon: Icons.add,
                        isVisibile: canEdit,
                      ),
                    ],
                  ),
                  AsyncValueSliverWidget(
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
                              value: RadioButtonReturnType(
                                value: pump.id,
                                label: pump.name,
                              ),
                              groupValue: RadioButtonReturnType(
                                value: selectedPumpId?.value ?? '',
                                label: selectedPumpId?.label ?? '',
                              ),
                              onChanged: (val) => ref
                                  .read(connectPumpsToSectorControllerProvider
                                      .notifier)
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
                ],
              ),
            ),

            // Confirm button
            SliverCTAButton(
              text: loc.genericConfirmButtonLabel,
              buttonType: ButtonType.primary,
              onPressed: () => Navigator.of(context).pop(selectedPumpId),
            ),
            gapH32,
          ],
        ),
      ),
    );
  }
}
