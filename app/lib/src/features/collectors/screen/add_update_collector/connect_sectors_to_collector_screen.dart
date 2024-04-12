import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/enums/button_types.dart';
import '../../../../config/routes/routes_enums.dart';
import '../../../../constants/app_sizes.dart';
import '../../data/collector_sector_repository.dart';
import 'connect_sectors_to_collector_controller.dart';
import '../../../sectors/data/sector_repository.dart';
import '../../../sectors/screen/empty_sector_widget.dart';
import '../../../../utils/extensions.dart';
import '../../../../widgets/app_cta_button.dart';
import '../../../../widgets/app_sliver_bar.dart';
import '../../../../widgets/async_value_widget.dart';
import '../../../../widgets/common_add_icon_button.dart';
import '../../../../widgets/padded_safe_area.dart';
import '../../../../widgets/responsive_checkbox_tile.dart';
import '../../../../widgets/sliver_adaptive_circular_indicator.dart';

class ConnectSectorsToCollector extends ConsumerWidget {
  const ConnectSectorsToCollector({
    super.key,
  });

  void _onSelectionChanged({
    required bool value,
    required String sectorId,
    required WidgetRef ref,
  }) {
    ref
        .read(connectSectorsToCollectorControllerProvider.notifier)
        .handleSelection(value: value, sectorId: sectorId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final availableSectors =
        ref.watch(sectorsNotConnectedToACollectorStreamProvider);
    final selectedSectorsId = ref.watch(selectedSectorsIdProvider);
    return Scaffold(
      body: PaddedSafeArea(
          child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                AppSliverBar(
                  title: loc.connectSectorToCollectorPageTitle,
                  actions: [
                    CommonAddIconButton(
                      onPressed: () =>
                          context.pushNamed(AppRoute.addSector.name),
                    ),
                  ],
                ),
                AsyncValueSliverWidget(
                  value: availableSectors,
                  data: (sectors) {
                    if (sectors.isEmpty) {
                      return Consumer(
                        builder: (context, ref, child) {
                          final companyGenerallyHasSectors = ref
                              .watch(sectorListStreamProvider)
                              .valueOrNull
                              ?.isNotEmpty ?? false;
                          return EmptySectorWidget(
                            alternativeMessage: companyGenerallyHasSectors
                                ? loc.allSectorsAreConnectedToACollector
                                : null,
                          );
                        },
                      );
                    }

                    // it should be save to assume that the sectors are not null here
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final sector = sectors[index]!;
                          final sectorIsSelected =
                              selectedSectorsId.contains(sector.id);
                          return ResponsiveCheckboxTile(
                            title: sector.name,
                            value: sectorIsSelected,
                            onChanged: (value) => _onSelectionChanged(
                              value: value ?? false,
                              sectorId: sector.id,
                              ref: ref,
                            ),
                          );
                        },
                        childCount: sectors.length,
                      ),
                    );
                  },
                  loading: () => const SliverAdaptiveCircularIndicator(),
                )
              ],
            ),
          ),
          // button to confirm selection
          Visibility(
            visible: availableSectors.valueOrNull?.isNotEmpty ?? false,
            child: SliverCTAButton(
              text: loc.genericConfirmButtonLabel,
              buttonType: ButtonType.primary,
              onPressed: () => context.popNavigator(),
            ),
          ),
          gapH32,
        ],
      )),
    );
  }
}
