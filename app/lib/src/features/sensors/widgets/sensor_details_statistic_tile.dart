import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';

class SensorDetailsStatisticTile extends StatelessWidget {
  const SensorDetailsStatisticTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ResponsiveDetailsCard(
      child: DetailTileWidget(
        title: title,
        subtitle: subtitle,
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
