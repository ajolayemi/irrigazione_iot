import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_status_indicator.dart';

class PumpTileTitle extends ConsumerWidget {
  const PumpTileTitle({super.key, required this.pump});

  final Pump pump;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSwitchedOn =
        ref.watch(pumpStatusStreamProvider(pump.id)).valueOrNull ?? false;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(pump.name),
        gapW8,
        CommonStatusIndicator(status: isSwitchedOn)
      ],
    );
  }
}
