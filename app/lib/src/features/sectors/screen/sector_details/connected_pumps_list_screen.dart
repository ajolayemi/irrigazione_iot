import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/widgets/responsive_list_tile.dart';
import 'package:irrigazione_iot/src/widgets/sliver_adaptive_circular_indicator.dart';

class SectorConnectedPumpsList extends ConsumerWidget {
  const SectorConnectedPumpsList({
    super.key,
    required this.sectorId,
  });

  final String sectorId;

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

  final String pumpId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pumpDetail =
        ref.watch(pumpStreamProvider(pumpId)).valueOrNull ?? Pump.empty();
    return ResponsiveListTile(
      title: Text(pumpDetail.name),
    );
  }
}
