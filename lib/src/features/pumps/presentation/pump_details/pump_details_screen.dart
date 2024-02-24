import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_details_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/utils/date_formatter.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/app_bar_icon_buttons.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

class PumpDetailsScreen extends ConsumerWidget {
  const PumpDetailsScreen({
    super.key,
    required this.pumpId,
  });

  final PumpID pumpId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pumpDetails = ref.watch(pumpDetailsStreamProvider(pumpId));
    final dateFormat = ref.watch(dateFormatProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: pumpDetails.value?.pump.name ?? 'N/A',
            actions: [
              // todo this button should be visible only when the current user operating
              // todo isn't a regular user
              AppBarIconButton(
                onPressed: () =>
                    showNotImplementedAlertDialog(context: context),
                icon: Icons.edit,
              ) // todo add logic to edit existing pump details
            ],
          ),

          
          AsyncValueSliverWidget(
              value: pumpDetails,
              data: (details) {
                final lastDispensation =
                    details?.lastDispensation ?? DateTime.now();
                return SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    ResponsiveCenter(
                      child: ListTile(
                        title: const Text('Total Litres Dispensed'),
                        subtitle: Text('${details?.totalLitresDispensed}'),
                      ),
                    ),
                    ResponsiveCenter(
                      child: ListTile(
                        title: const Text('Last Dispensation'),
                        subtitle: Text(dateFormat.format(lastDispensation)),
                      ),
                    ),
                  ]),
                );
              }),
        ],
      ),
    );
  }
}
