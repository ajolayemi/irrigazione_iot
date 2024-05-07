import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';
import 'package:irrigazione_iot/src/features/variety/data/variety_repository.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_expansion_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';

class SectorDetailsCharacteristics extends ConsumerWidget {
  const SectorDetailsCharacteristics({
    super.key,
    required this.sector,
  });

  final Sector sector;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return CommonExpansionTile(
      title: loc.entityCharacteristics,
      children: [
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
        ),
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.mqttMessageNameFormFieldTitle,
            subtitle: sector.mqttMsgName,
          ),
        ),
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.mqttOnCommand,
            subtitle: sector.turnOnCommand,
          ),
        ),
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.mqttOffCommand,
            subtitle: sector.turnOffCommand,
          ),
        ),
      ],
    );
  }
}
