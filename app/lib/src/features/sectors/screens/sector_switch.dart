import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_switch_controller.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class SectorSwitch extends ConsumerWidget {
  const SectorSwitch({
    super.key,
    required this.sector,
  });

  final Sector sector;

  // * Keys for testing using find.byKey
  static Key sectorStatusSwitchKey(Sector sector) =>
      Key('sectorStatusSwitchKey_${sector.id}');

  Future<void> _toggleSwitch(
    BuildContext context,
    WidgetRef ref,
    bool status,
  ) async {
    final canContinue = await context.showStatusToggleDialog(
      status: status,
      what: sector.name,
    );

    if (!canContinue) return;

    ref
        .read(sectorSwitchControllerProvider.notifier)
        .toggleStatus(sector, status);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thisSectorStatusIsLoading = ref
        .watch(sectorSwitchControllerProvider)
        .stateWithIdIsLoading(sector.id);

    final globalLoadingState =
        ref.watch(sectorSwitchControllerProvider).isGlobalLoading;

    final isSwitchedOn =
        ref.watch(sectorStatusStreamProvider(sector.id)).valueOrNull?.statusBoolean ?? false;

    return thisSectorStatusIsLoading
        ? const CircularProgressIndicator.adaptive()
        : IgnorePointer(
            ignoring: globalLoadingState,
            child: Switch.adaptive(
              key: sectorStatusSwitchKey(sector),
              value: isSwitchedOn,
              onChanged: (status) async =>
                  await _toggleSwitch(context, ref, status),
            ),
          );
  }
}
