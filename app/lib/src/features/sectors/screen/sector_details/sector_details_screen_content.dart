import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_status.dart';
import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';
import 'package:irrigazione_iot/src/features/variety/data/variety_repository.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';
import 'package:irrigazione_iot/src/utils/date_formatter.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class SectorDetailsScreenContents extends ConsumerWidget {
  const SectorDetailsScreenContents({
    super.key,
    required this.sector,
    this.sectorStatus,
  });

  final Sector sector;
  final SectorStatus? sectorStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          ResponsiveDetailsCard(
            child: Consumer(
              builder: (context, ref, child) {
                final lastIrrigated = ref
                    .watch(sectorLastPressureStreamProvider(sector.id))
                    .valueOrNull;
                final dateFormatter = ref.watch(dateFormatWithTimeProvider);
                return DetailTileWidget(
                  title: context.loc.sectorLastIrrigationForTile,
                  subtitle: lastIrrigated == null
                      ? context.loc.sectorLastIrrigationEmpty
                      : dateFormatter.format(lastIrrigated),
                );
              },
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final sectorPump =
                  ref.watch(sectorPumpStreamProvider(sector.id)).valueOrNull;
              final pump = ref
                  .watch(pumpStreamProvider(sectorPump?.pumpId ?? '0'))
                  .valueOrNull;
              return ResponsiveDetailsCard(
                child: DetailTileWidget(
                  title: context.loc.sectorConnectedPumps,
                  subtitle: pump?.name ?? loc.notAvailable,
                ),
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final specieName = ref
                  .watch(specieStreamProvider(sector.specieId))
                  .valueOrNull
                  ?.name;
              return ResponsiveDetailsCard(
                child: DetailTileWidget(
                  title: context.loc.sectorSpecie,
                  subtitle: specieName ?? loc.notAvailable,
                ),
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final varietyName = ref
                  .watch(varietyStreamProvider(sector.varietyId))
                  .valueOrNull
                  ?.name;
              return ResponsiveDetailsCard(
                child: DetailTileWidget(
                  title: context.loc.sectorVariety,
                  subtitle: varietyName ?? loc.notAvailable,
                ),
              );
            },
          ),
          ResponsiveDetailsCard(
            child: DetailTileWidget(
              title: context.loc.sectorNumberOfPlants,
              subtitle: sector.numOfPlants.toString(),
            ),
          ),
          ResponsiveDetailsCard(
            child: DetailTileWidget(
              title: context.loc.sectorUnitConsumptionPerHour,
              subtitle: sector.waterConsumptionPerHour.toString(),
            ),
          ),
          ResponsiveDetailsCard(
            child: DetailTileWidget(
              title: context.loc.sectorTotalConsumption,
              subtitle: sector.totalConsumption.toString(),
            ),
          ),
          ResponsiveDetailsCard(
            child: DetailTileWidget(
              title: context.loc.sectorIrrigationSystem,
              subtitle: sector.irrigationSystemType.uiName,
            ),
          ),
          ResponsiveDetailsCard(
            child: DetailTileWidget(
              title: context.loc.sectorIrrigationSource,
              subtitle: sector.irrigationSource.uiName,
            ),
          ),
          ResponsiveDetailsCard(
            child: DetailTileWidget(
              title: context.loc.sectorNotes,
              subtitle: sector.notes,
            ),
          )
        ],
      ),
    );
  }
}
