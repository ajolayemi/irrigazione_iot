import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_status.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/sector_switch.dart';
import 'package:irrigazione_iot/src/utils/date_formatter.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/widgets/responsive_details_card.dart';

class SectorDetailsScreenContents extends ConsumerWidget {
  const SectorDetailsScreenContents(
      {super.key, required this.sector, this.sectorStatus});

  final Sector sector;
  final SectorStatus? sectorStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          ResponsiveDetailsCard(
            child: Consumer(
              builder: (context, ref, child) {
                final status =
                    ref.watch(sectorStatusStreamProvider(sector)).valueOrNull ??
                        false;
                return DetailTileWidget(
                  title: context.loc.statusListTileTitle,
                  subtitle: status
                      ? context.loc.onStatusValue
                      : context.loc.offStatusValue,
                  trailing: SectorSwitch(
                    sector: sector,
                  ),
                );
              },
            ),
          ),
          ResponsiveDetailsCard(child: Consumer(builder: (context, ref, child) {
            final lastIrrigated = ref
                .watch(sectorLastIrrigatedStreamProvider(sector))
                .valueOrNull;
            final dateFormatter = ref.watch(dateFormatWithTimeProvider);
            return DetailTileWidget(
              title: context.loc.sectorLastIrrigationForTile,
              subtitle: lastIrrigated == null
                  ? context.loc.sectorLastIrrigationEmpty
                  : dateFormatter.format(lastIrrigated),
            );
          })),
          ResponsiveDetailsCard(
            child: DetailTileWidget(
              title: context.loc.sectorSpecie,
              subtitle: sector.availableSpecie,
            ),
          ),
          ResponsiveDetailsCard(
            child: DetailTileWidget(
              title: context.loc.sectorVariety,
              subtitle: sector.specieVariety,
            ),
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
              subtitle: sector.waterConsumptionPerHourByPlant.toString(),
            ),
          ),
          ResponsiveDetailsCard(
            child: DetailTileWidget(
              title: context.loc.sectorTotalConsumption,
              subtitle: sector.totalWaterConsumption.toString(),
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