import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_switch.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sector_list_tile_subtitle.dart';
import 'package:irrigazione_iot/src/features/sectors/widgets/sector_tile_title.dart';

class SectorListTileItem extends StatelessWidget {
  const SectorListTileItem({
    super.key,
    required this.sector,
  });

  final Sector sector;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: SectorTileTitle(sector: sector),
        isThreeLine: true,
        subtitle: SectorListTileSubtitle(sector: sector),
        trailing: SectorSwitch(sector: sector));
  }
}