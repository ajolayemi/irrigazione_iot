import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/pump_status/pump_status_switch_controller.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/pump_status/pump_status_switch_widget.dart';
import 'package:irrigazione_iot/src/utils/date_formatter.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

class PumpStatusTileWidget extends ConsumerWidget {
  const PumpStatusTileWidget({
    super.key,
    required this.pump,
    this.title,
    this.onTap,
  });

  final Pump pump;
  final String? title;
  final VoidCallback? onTap;

  // Key for testing using find.byKey
  static Key pumpStatusTileKey(Pump pump) =>
      Key('pumpStatusTileKey_${pump.id}');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormatter = ref.watch(dateFormatWithTimeProvider);
    final lastDispensationDate =
        ref.watch(lastDispensationStreamProvider(pump.id)).valueOrNull;
    final pumpStatus = ref.watch(pumpStatusStreamProvider(pump.id)).valueOrNull;

    final aPumpIsCurrentlyLoading = ref.watch(
        pumpStatusSwitchControllerProvider.select(
            (state) => (state.value?.isLoading ?? false) && !state.hasError));

    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      child: InkWell(
        onTap: aPumpIsCurrentlyLoading ? null : onTap,
        child: ListTile(
          title: Text(title ?? ''),
          subtitleTextStyle:
              context.textTheme.titleSmall?.copyWith(color: Colors.grey),
          subtitle:  Text(
            context.loc.pumpStatusLastSwitchedOn(
              lastDispensationDate == null
                  ? context.loc.notAvailable
                  : dateFormatter
                      .format(lastDispensationDate),
            ),
          ),
          trailing: PumpStatusSwitchWidget(
            pump: pump,
            pumpStatus: pumpStatus,
          ),
        ),
      ),
    );
  }
}
