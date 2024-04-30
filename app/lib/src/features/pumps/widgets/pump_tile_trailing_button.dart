import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_status_controller.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class PumpTileTrailingButton extends ConsumerWidget {
  const PumpTileTrailingButton({
    super.key,
    required this.pump,
  });

  final Pump pump;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final isSwitchedOn =
        ref.watch(pumpStatusStreamProvider(pump.id)).valueOrNull ?? false;
    final currentCompany = ref.watch(currentTappedCompanyProvider).valueOrNull;
    return OutlinedButton(
      onPressed: () =>
          ref.read(pumpStatusControllerProvider.notifier).toggleStatus(
                pump,
                false,
                currentCompany?.mqttTopicName ?? '',
              ),
      child: Text(
        isSwitchedOn ? loc.switchOff : loc.switchOn,
        style: TextStyle(
          color: isSwitchedOn ?  Colors.red : Colors.green,
        ),
      ),
    );
  }
}
