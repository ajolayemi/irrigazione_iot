import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/widgets/custom_edit_icon_button.dart';
import 'package:irrigazione_iot/src/widgets/sliver_adaptive_circular_indicator.dart';

class CollectorDetailsScreen extends ConsumerWidget {
  const CollectorDetailsScreen({
    super.key,
    required this.collectorId,
  });

  final CollectorID collectorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectorData = ref.watch(collectorStreamProvider(collectorId));
    final connectedSectors =
        ref.watch(collectorSectorsStreamProvider(collectorId));

    return Scaffold(
      body: SafeArea(
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
                    CustomEditIconButton(
                      onPressed: () => context.pushNamed(
                        AppRoute.updateCollector.name,
                        pathParameters: {
                          'collectorId': collector.id,
                        },
                      ),
                    )
                  ],
                )
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
