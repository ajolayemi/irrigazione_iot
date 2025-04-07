import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/dashboard_child_item_details_row.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions/datetime_extensions.dart';

/// Displays for how long the pump has been running.
class PumpIrrigationDuration extends ConsumerWidget {
  const PumpIrrigationDuration({super.key, required this.pumpId});

  final String pumpId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pumpStatus = ref.watch(pumpStatusStreamProvider(pumpId)).valueOrNull;
    return DashboardChildItemDetailsRow(
      leading: const Text('Durata irrigazione'),
      trailing: Timeago(
        builder: (_, __) {
          return Text('${pumpStatus?.createdAt.toDurationString}');
        },
        date: pumpStatus?.createdAt ?? DateTime.now(),
        refreshRate: const Duration(seconds: 1),
      ),
    );
  }
}
