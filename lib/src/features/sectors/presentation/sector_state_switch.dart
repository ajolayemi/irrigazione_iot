import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';

class SectorStateSwitch extends ConsumerWidget {
  const SectorStateSwitch({
    super.key,
    required this.sectorID,
  });

  final SectorID sectorID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // todo implement the switch
    return Switch.adaptive(
      value: true,
      onChanged: (_) {},
    );
  }
}
