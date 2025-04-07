import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/common_pressure_rate_trailing_text.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/dashboard_child_item_details_row.dart';
import 'package:irrigazione_iot/src/features/terminal/data/terminal_pressure_repository.dart';

class TerminalPressureForDashboard extends ConsumerWidget {
  const TerminalPressureForDashboard({super.key, required this.sectorId});

  final String sectorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectorId = ref
        .watch(
          collectorIdBySectorIdStreamProvider(sectorId),
        )
        .valueOrNull;

    if (collectorId == null) {
      return const TerminalPressureForDashboardContent();
    }

    return Consumer(
      builder: (context, ref, child) {
        final terminalPressure =
            ref.watch(terminalPressureStreamProvider(collectorId));
        final pressure = terminalPressure.valueOrNull?.pressure;
        return TerminalPressureForDashboardContent(
          pressure: pressure,
        );
      },
    );
  }
}

class TerminalPressureForDashboardContent extends StatelessWidget {
  const TerminalPressureForDashboardContent({super.key, this.pressure});

  final double? pressure;

  @override
  Widget build(BuildContext context) {
    return DashboardChildItemDetailsRow(
      leading: const Text('Pressione terminale'),
      trailing: CommonPressureRateTrailingText(
        pressure: pressure ?? 0.0,
      ),
    );
  }
}
