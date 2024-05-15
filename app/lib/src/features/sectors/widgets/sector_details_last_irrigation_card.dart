import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pressure_repository.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

/// A card that shows the last date a sector was irrigated
class SectorDetailsLastIrrigationCard extends ConsumerWidget {
  const SectorDetailsLastIrrigationCard({super.key, required this.sectorId});

  final String sectorId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final lastIrrigation = ref
        .watch(sectorLastPressureStreamProvider(sectorId))
        .valueOrNull
        ?.createdAt;

    if (lastIrrigation == null) {
      return ResponsiveDetailsCard(
        child: DetailTileWidget(
          title: loc.sectorLastIrrigationForTile,
          subtitle: loc.notAvailable,
        ),
      );
    }

    return Timeago(
      builder: (_, value) => ResponsiveDetailsCard(
        child: DetailTileWidget(
          title: loc.sectorLastIrrigationForTile,
          subtitle: context.customFormatDateTime(
            timeAgoDateString: value,
            dateTime: lastIrrigation,
          ),
        ),
      ),
      date: lastIrrigation,
      locale: context.locale,
    );
  }
}