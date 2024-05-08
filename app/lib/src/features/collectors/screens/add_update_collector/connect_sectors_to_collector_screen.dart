import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/screens/add_update_collector/connect_sectors_to_collector_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/data/available_sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/available_sector.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/empty_sector_widget.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_checkbox_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/sliver_adaptive_circular_indicator.dart';

class ConnectSectorsToCollector extends ConsumerWidget {
  const ConnectSectorsToCollector({super.key, this.idOfCollectorBeingEdited});

  final String? idOfCollectorBeingEdited;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final availableSectors = ref.watch(availableSectorsStreamProvider(
      collectorId: idOfCollectorBeingEdited,
    ));
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
                  data: (data) {
                    if (data == null) {
                      return Consumer(
                        builder: (context, ref, child) {
                          final companyGenerallyHasSectors =
                              ref.watch(sectorListStreamProvider);
                          final itDoes = companyGenerallyHasSectors
                                  .valueOrNull?.isNotEmpty ??
                              false;
                          return EmptySectorWidget(
                            alternativeMessage: itDoes
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
                          final availableSector = data[index];
                          return ConnectSectorsToCollectorCheckboxItem(
                            availableSector: availableSector,
                          );
                        },
                        childCount: data.length,
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

class ConnectSectorsToCollectorCheckboxItem extends ConsumerWidget {
  const ConnectSectorsToCollectorCheckboxItem({
    super.key,
    required this.availableSector,
  });

  final AvailableSector availableSector;

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
    final sector =
        ref.watch(sectorStreamProvider(availableSector.sectorId)).valueOrNull;
    final selectedSectorsId = ref.watch(selectedSectorsIdProvider);
    final sectorIsSelected = selectedSectorsId.contains(sector?.id);

    if (sector == null) {
      return const SizedBox();
    }
    return ResponsiveCheckboxTile(
      title: sector.name,
      value: sectorIsSelected,
      onChanged: (value) => _onSelectionChanged(
        value: value ?? false,
        sectorId: sector.id,
        ref: ref,
      ),
    );
  }
}
