import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/pump_status_repository.dart';
import '../model/pump.dart';
import '../../../utils/date_formatter.dart';
import '../../../utils/extensions.dart';

class PumpListTileSubtitle extends ConsumerWidget {
  const PumpListTileSubtitle({
    super.key,
    required this.pump,
  });

  final Pump pump;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormatter = ref.watch(dateFormatWithTimeProvider);
    final loc = context.loc;
    final lastDispensationDate =
        ref.watch(lastDispensationStreamProvider(pump.id)).valueOrNull;
    return Text(
      loc.pumpStatusLastSwitchedOn(
        lastDispensationDate == null
            ? loc.notAvailable
            : dateFormatter.format(lastDispensationDate),
      ),
      style: context.textTheme.titleSmall?.copyWith(
        color: Colors.grey,
      ),
    );
  }
}
