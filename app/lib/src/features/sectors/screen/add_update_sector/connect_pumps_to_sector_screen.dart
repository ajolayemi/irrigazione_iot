import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/enums/button_types.dart';
import '../../../../config/enums/roles.dart';
import '../../../../config/routes/routes_enums.dart';
import '../../../../constants/app_sizes.dart';
import '../../../pumps/data/pump_repository.dart';
import '../../../pumps/screen/empty_pump_widget.dart';
import '../../data/sector_pump_repository.dart';
import 'connect_pumps_to_sector_controller.dart';
import '../../../company_users/data/company_users_repository.dart';
import '../../../../utils/extensions.dart';
import '../../../../widgets/app_bar_icon_buttons.dart';
import '../../../../widgets/app_cta_button.dart';
import '../../../../widgets/app_sliver_bar.dart';
import '../../../../widgets/async_value_widget.dart';
import '../../../../widgets/padded_safe_area.dart';
import '../../../../widgets/responsive_checkbox_tile.dart';

class ConnectPumpsToSector extends ConsumerWidget {
  const ConnectPumpsToSector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canEdit = ref.watch(companyUserRoleProvider).valueOrNull?.canEdit;
    final availablePumps = ref.watch(companyPumpsStreamProvider);
    final selectedPumpsId = ref.watch(selectedPumpsIdProvider);
    final loc = context.loc;
    return Scaffold(
      body: PaddedSafeArea(
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
