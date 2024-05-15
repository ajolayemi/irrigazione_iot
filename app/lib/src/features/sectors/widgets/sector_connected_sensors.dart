import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sensors/data/sensor_repository.dart';

class SectorConnectedSensors extends ConsumerWidget {
  const SectorConnectedSensors({super.key, required this.sectorId});

  final String sectorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensorsConnectedToSector =
        ref.watch(sensorsCountStreamProvider(sectorId)).valueOrNull ?? 0;
    return Badge(
      label: Text(sensorsConnectedToSector.toString()),
      backgroundColor: Colors.blue,
      child: const Icon(Icons.sensors),
    );
  }
}
