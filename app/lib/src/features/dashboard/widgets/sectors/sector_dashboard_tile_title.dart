import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/dashboard_child_item_details_row.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_switch.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_status_indicator.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class SectorDashboardTileTitle extends ConsumerWidget {
  const SectorDashboardTileTitle({
    super.key,
    required this.sector,
  });

  final Sector sector;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    return DashboardChildItemDetailsRow(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              sector.name,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          gapW8,
          const CommonStatusIndicator(status: true),
        ],
      ),
      trailing: SectorSwitch(sector: sector),
    );
  }
}
