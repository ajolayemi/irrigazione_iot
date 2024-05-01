import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

/// A shared custom expansion tile that can be used in different screens
/// Mostly used in the details screen of a specific entity
class CommonExpansionTile extends StatelessWidget {
  const CommonExpansionTile({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: context.textTheme.titleLarge,
      ),
      children: children,
    );
  }
}
