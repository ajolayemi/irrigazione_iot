import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump_details.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/pump_status/pum_status_tile_wid.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

class PumpDetailsSliverList extends ConsumerWidget {
  const PumpDetailsSliverList({super.key, required this.pumpDetails});

  final PumpDetails pumpDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pump = ref.watch(pumpStreamProvider(pumpDetails.id)).value!;
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        PumpDetailsCard(
          child: PumpStatusTileWidget(
            pump: pump,
            title: context.loc.pumpStatusListTileTitle,
          ),
        ),
        PumpDetailsCard(
          child: PumpDetailTileWidget(
            title: 'Capacity in volume',
            subtitle: '${pumpDetails.capacityInVolume.toString()} m³',
          ),
        ),
        PumpDetailsCard(
          child: PumpDetailTileWidget(
            title: 'Consume rate in kW',
            subtitle: '${pumpDetails.consumeRateInKw.toString()} kW',
          ),
        ),
        PumpDetailsCard(
          child: PumpDetailTileWidget(
            title: 'Total litres dispensed',
            subtitle: '${pumpDetails.totalLitresDispensed.toString()} L',
          ),
        ),
      ]),
    );
  }
}

// * Tile to display pump details
class PumpDetailTileWidget extends StatelessWidget {
  const PumpDetailTileWidget({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
  });

  final String? title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitleTextStyle:
          context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
      titleTextStyle: context.textTheme.bodyLarge?.copyWith(
        color: Colors.transparent.withOpacity(0.8),
      ),
      title: Text(title ?? ''),
      subtitle: Text(subtitle ?? ''),
      trailing: trailing,
    );
  }
}

// * Card to display pump details
class PumpDetailsCard extends StatelessWidget {
  const PumpDetailsCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      padding: const EdgeInsets.all(Sizes.p8),
      child: Card(
        elevation: 2,
        surfaceTintColor: Colors.transparent.withOpacity(0.2),
        child: child,
      ),
    );
  }
}
