import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../pumps/data/pump_repository.dart';
import '../../../pumps/model/pump.dart';
import '../../data/sector_pump_repository.dart';
import '../../model/sector.dart';
import '../../../../utils/extensions.dart';
import '../../../../widgets/app_sliver_bar.dart';
import '../../../../widgets/async_value_widget.dart';
import '../../../../widgets/responsive_list_tile.dart';
import '../../../../widgets/sliver_adaptive_circular_indicator.dart';

class SectorConnectedPumpsList extends ConsumerWidget {
  const SectorConnectedPumpsList({
    super.key,
    required this.sectorId,
  });

  final SectorID sectorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: loc.sectorConnectedPumps,
          ),
          Consumer(builder: (context, ref, child) {
            final sectorConnectedPumps =
                ref.watch(sectorPumpsStreamProvider(sectorId));
            return AsyncValueSliverWidget(
                value: sectorConnectedPumps,
                data: (sectorPumps) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      // this page is only reachable if the sector has pumps,
                      // so we can safely assume that sectorPumps is not null
                      final pump = sectorPumps[index]!;
                      return SectorConnectedPumpsTile(
                        pumpId: pump.pumpId,
                      );
                    }, childCount: sectorPumps.length),
                  );
                },
                loading: () => const SliverAdaptiveCircularIndicator());
          })
        ],
      )),
    );
  }
}

class SectorConnectedPumpsTile extends ConsumerWidget {
  const SectorConnectedPumpsTile({
    super.key,
    required this.pumpId,
  });

  final PumpID pumpId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pumpDetail =
        ref.watch(pumpStreamProvider(pumpId)).valueOrNull ?? const Pump.empty();
    return ResponsiveListTile(
      title: Text(pumpDetail.name),
    );
  }
}
