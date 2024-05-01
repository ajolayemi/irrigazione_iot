import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class PumpListTileSubtitle extends ConsumerWidget {
  const PumpListTileSubtitle({
    super.key,
    required this.pump,
  });

  final Pump pump;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final lastDispensationDate =
        ref.watch(lastDispensationStreamProvider(pump.id)).valueOrNull;
    return Text(
      loc.pumpStatusLastSwitchedOn(
        lastDispensationDate == null
            ? loc.notAvailable
            : timeago.format(
                lastDispensationDate,
                locale: context.locale,
              ),
      ),
      style: context.textTheme.titleSmall?.copyWith(
        color: Colors.grey,
      ),
    );
  }
}
