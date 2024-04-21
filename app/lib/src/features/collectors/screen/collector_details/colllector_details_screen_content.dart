import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/collector_sector_repository.dart';
import '../../model/collector.dart';
import '../../../../utils/extensions.dart';
import '../../../../widgets/details_tile_widget.dart';
import '../../../../widgets/responsive_details_card.dart';

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
            subtitle: collector.filterName,
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
