import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/dashboard_child_item_details_row.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions/datetime_extensions.dart';
import 'package:timeago_flutter/timeago_flutter.dart';


/// Displays for how log
class SectorIrrigationDuration extends ConsumerWidget {
  const SectorIrrigationDuration({super.key, required this.sectorId});

  final String sectorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectorStatus = ref.watch(sectorStatusStreamProvider(sectorId)).valueOrNull;
    return DashboardChildItemDetailsRow(
      leading: const Text('Irrigato da'),
      trailing: Timeago(
        builder: (_, __) {
          return Text('${sectorStatus?.createdAt.toDurationString}');
        },
        date: sectorStatus?.createdAt ?? DateTime.now(),
        refreshRate: const Duration(seconds: 1),
      ),
    );
  }
}