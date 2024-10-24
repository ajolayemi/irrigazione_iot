import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

/// A card that shows the last dispensation of a pump
class PumpDetailsLastDispensationCard extends ConsumerWidget {
  const PumpDetailsLastDispensationCard({super.key, required this.pumpId});

  final String pumpId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final lastDispensationDate =
        ref.watch(lastDispensationStreamProvider(pumpId)).valueOrNull;

    if (lastDispensationDate == null) {
      return ResponsiveDetailsCard(
        child: DetailTileWidget(
          title: loc.pumpLastDispensationForTile,
          subtitle: loc.notAvailable,
        ),
      );
    }

    return Timeago(
      builder: (_, value) => ResponsiveDetailsCard(
          child: DetailTileWidget(
        title: loc.pumpLastDispensationForTile,
        subtitle: context.customFormatDateTime(
          timeAgoDateString: value,
          dateTime: lastDispensationDate,
        ),
      )),
      date: lastDispensationDate,
      locale: context.locale,
    );
  }
}
