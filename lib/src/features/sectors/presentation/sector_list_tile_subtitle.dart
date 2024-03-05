import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';

class SectorListTileSubtitle extends ConsumerWidget {
  const SectorListTileSubtitle({super.key, required this.sector});

  final Sector sector;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // todo implement the last irrigated date
    return Text('${sector.displayName}\nlast irrigated: to do');
  }
}
