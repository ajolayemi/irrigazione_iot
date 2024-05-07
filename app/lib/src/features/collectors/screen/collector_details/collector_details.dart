import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_sector.dart';
import 'package:irrigazione_iot/src/features/collectors/screen/collector_details/collector_details_screen_content.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_edit_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';

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
    ref.read(selectedSectorsIdProvider.notifier).state = sectorIds;
    final params = PathParameters(id: collectorId).toJson();
    context.pushNamed(AppRoute.updateCollector.name, pathParameters: params);
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
