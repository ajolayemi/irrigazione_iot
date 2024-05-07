import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';

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
        context.timeAgo(
          lastDispensationDate,
          fallbackValue: loc.notAvailable,
        ),
      ),
      style: context.textTheme.titleSmall?.copyWith(
        color: Colors.grey,
      ),
    );
  }
}
