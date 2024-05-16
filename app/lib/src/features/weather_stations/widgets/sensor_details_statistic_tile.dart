import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/utils/extensions/string_extensions.dart';

class SensorDetailsStatisticTile extends StatelessWidget {
  const SensorDetailsStatisticTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.keyForUm,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final String keyForUm;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ResponsiveDetailsCard(
      child: DetailTileWidget(
        title: title,
        subtitle: subtitle == null
            ? context.loc.notAvailable
            : '$subtitle ${keyForUm.getUmX(keyForUm)}',
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
