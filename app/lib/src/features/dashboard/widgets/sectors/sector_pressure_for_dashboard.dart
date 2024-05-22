import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/common_pressure_rate_trailing_text.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/dashboard_child_item_details_row.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pressure_repository.dart';

class SectorPressureForDashboard extends ConsumerWidget {
  const SectorPressureForDashboard({super.key, required this.sectorId});

  final String sectorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pressure =
        ref.watch(sectorLastPressureStreamProvider(sectorId)).valueOrNull;

    return DashboardChildItemDetailsRow(
      leading: const Text('Pressione settore'),
      trailing:
          CommonPressureRateTrailingText(pressure: pressure?.pressure ?? 0.0),
    );
  }
}
