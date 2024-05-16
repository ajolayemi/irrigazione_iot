import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_expansion_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class WeatherStationDetailsCharacteristics extends ConsumerWidget {
  const WeatherStationDetailsCharacteristics({
    super.key,
    required this.weatherStation,
  });

  final WeatherStation weatherStation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;

    return CommonExpansionTile(
      title: loc.entityCharacteristics,
      children: [
        ResponsiveDetailsCard(
          child: DetailTileWidget(
            title: loc.deviceEui,
            subtitle: weatherStation.eui,
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final sectorConnected =
                ref.watch(sectorStreamProvider(weatherStation.sectorId));
            final value = sectorConnected.valueOrNull;
            return ResponsiveDetailsCard(
                child: DetailTileWidget(
              title: loc.connectedSector,
              subtitle: value?.name ?? loc.notAvailable,
            ));
          },
        )
      ],
    );
  }
}
