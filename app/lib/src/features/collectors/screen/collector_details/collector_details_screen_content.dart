import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/widgets/responsive_details_card.dart';


class CollectorDetailsScreenContents extends ConsumerWidget {
  const CollectorDetailsScreenContents({
    super.key,
    required this.collector,
  });

  final Collector collector;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return SliverList(
        delegate: SliverChildListDelegate.fixed(
      [
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.collectorFilterName,
            subtitle: collector.connectedFilterName,
          ),
        ),
        ResponsiveDetailsCard(child: Consumer(
          builder: (context, ref, child) {
            final connectedSectors = ref
                    .watch(collectorSectorsStreamProvider(collector.id))
                    .valueOrNull
                    ?.length ??
                0;
            return DetailTileWidget(
              title: loc.collectorConnectedSectors,
              subtitle: loc.nConnectedSectors(connectedSectors),
            );
          },
        ))
      ],
    ));
  }
}
