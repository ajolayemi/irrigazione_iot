import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago_flutter/timeago_flutter.dart';
import 'package:irrigazione_iot/src/config/styles/app_styles.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class PumpListTileSubtitle extends ConsumerWidget {
  const PumpListTileSubtitle({
    super.key,
    required this.pump,
  });

  final Pump pump;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastDispensationDate =
        ref.watch(lastDispensationStreamProvider(pump.id)).valueOrNull;

    if (lastDispensationDate == null) {
      return const PumpListTileSubtitleContent();
    }

    return Timeago(
      builder: (_, value) {
        return PumpListTileSubtitleContent(
          lastDispensedString: value,
        );
      },
      date: lastDispensationDate,
      locale: context.locale,
    );
  }
}

class PumpListTileSubtitleContent extends StatelessWidget {
  const PumpListTileSubtitleContent({
    super.key,
    this.lastDispensedString,
  });

  final String? lastDispensedString;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return Text(
      lastDispensedString == null
          ? loc.notAvailable
          : loc.pumpFlowLastUpdate(lastDispensedString!),
      style: context.commonSubtitleStyle,
    );
  }
}
