import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_list/pump_status_controller.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';

class PumpTileTrailingButton extends ConsumerWidget {
  const PumpTileTrailingButton({
    super.key,
    required this.pump,
  });

  final Pump pump;

  Future<void> _toggleStatus(
      BuildContext context, WidgetRef ref, bool status) async {
    final canContinue =
        await context.showStatusToggleDialog(status: status, what: pump.name);
    if (!canContinue) return;

    ref.read(pumpStatusControllerProvider.notifier).toggleStatus(pump, status);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final aPumpIsBeingSwitchedOn =
        ref.watch(pumpStatusControllerProvider).isGlobalLoading;

    final thisPumpStatusIsLoading =
        ref.watch(pumpStatusControllerProvider).stateWithIdIsLoading(pump.id);
    final isSwitchedOn =
        ref.watch(pumpStatusStreamProvider(pump.id)).valueOrNull ?? false;
    return thisPumpStatusIsLoading
        ? const CircularProgressIndicator.adaptive()
        : IgnorePointer(
            ignoring: aPumpIsBeingSwitchedOn,
            child: OutlinedButton(
              onPressed: () async =>
                  await _toggleStatus(context, ref, !isSwitchedOn),
              child: Text(
                isSwitchedOn ? loc.switchOff : loc.switchOn,
                style: TextStyle(
                  color: isSwitchedOn ? Colors.red : Colors.green,
                ),
              ),
            ),
          );
  }
}
