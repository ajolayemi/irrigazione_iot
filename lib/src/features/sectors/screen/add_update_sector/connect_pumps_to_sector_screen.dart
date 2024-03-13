import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/empty_pump_widget.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/add_update_sector/connect_pumps_to_sector_controller.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/user_companies_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_bar_icon_buttons.dart';
import 'package:irrigazione_iot/src/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/widgets/responsive_checkbox_tile.dart';

class ConnectPumpsToSector extends ConsumerWidget {
  const ConnectPumpsToSector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canEdit = ref.watch(companyUserRoleProvider).valueOrNull?.canEdit;
    final availablePumps = ref.watch(companyPumpsStreamProvider);
    final selectedPumpsId = ref.watch(selectedPumpsIdProvider);
    final loc = context.loc;
    return Scaffold(
      body: SafeArea(
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
                      if (pumps.isEmpty) {
                        return const EmptyPumpWidget();
                      }

                      // it should be save to assume that the pumps are not null here
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final pump = pumps[index]!;
                            final pumpIsSelected =
                                selectedPumpsId.contains(pump.id);
                            return ResponsiveCheckboxTile(
                              title: pump.name,
                              value: pumpIsSelected,
                              onChanged: (val) => ref
                                  .read(connectPumpsToSectorControllerProvider
                                      .notifier)
                                  .handleSelection(val ?? false, pump.id),
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
              text: 'Confirm',
              buttonType: ButtonType.primary,
              onPressed: () =>
                  Navigator.of(context).pop(selectedPumpsId.length),
            ),
            gapH32,
          ],
        ),
      ),
    );
  }
}
