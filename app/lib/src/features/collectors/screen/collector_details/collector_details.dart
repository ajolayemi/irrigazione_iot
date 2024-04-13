import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/routes_enums.dart';

import '../../data/collector_repository.dart';
import '../../data/collector_sector_repository.dart';
import '../../model/collector_sector.dart';
import 'colllector_details_screen_content.dart';
import '../../../../widgets/app_sliver_bar.dart';
import '../../../../widgets/async_value_widget.dart';
import '../../../../widgets/common_edit_icon_button.dart';
import '../../../../widgets/padded_safe_area.dart';

class CollectorDetailsScreen extends ConsumerWidget {
  const CollectorDetailsScreen({
    super.key,
    required this.collectorId,
  });

  final String collectorId;

  void _onEditCollector(
      {required WidgetRef ref,
      required BuildContext context,
      required List<CollectorSector?> connectedSectors}) {
    final sectorIds = connectedSectors.map((e) => e?.sectorId).toList();
    ref.read(sectorIdsOfCollectorBeingEditedProvider.notifier).state =
        sectorIds;
    ref.read(selectedSectorsIdProvider.notifier).state = sectorIds;
    context.pushNamed(
      AppRoute.updateCollector.name,
      pathParameters: {
        'collectorId': collectorId,
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectorData = ref.watch(collectorStreamProvider(collectorId));
    final connectedSectors =
        ref.watch(collectorSectorsStreamProvider(collectorId)).valueOrNull;

    return Scaffold(
      body: PaddedSafeArea(
        child: AsyncValueSliverWidget(
          value: collectorData,
          data: (collector) {
            if (collector == null) {
              return const Text('no data was found');
            }

            return CustomScrollView(
              slivers: [
                AppSliverBar(
                  title: collector.name,
                  actions: [
                    CommonEditIconButton(
                      onPressed: () => _onEditCollector(
                        connectedSectors: connectedSectors ?? [],
                        ref: ref,
                        context: context,
                      ),
                    ),
                  ],
                ),
                CollectorDetailsScreenContents(
                  collector: collector,
                ),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
