// * Tile to display details of items like pumps, sectors etc
import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class DetailTileWidget extends StatelessWidget {
  const DetailTileWidget({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
  });

  final String? title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitleTextStyle:
          context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
      titleTextStyle: context.textTheme.bodyLarge?.copyWith(
        color: Colors.transparent.withOpacity(0.8),
      ),
      title: Text(title ?? ''),
      subtitle: Text(subtitle ?? ''),
      trailing: trailing,
    );
  }
}