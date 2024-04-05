import 'package:flutter/material.dart';
import '../constants/breakpoints.dart';
import '../utils/extensions.dart';
import 'responsive_center.dart';

/// A common widget to display a radio list tile with a label
/// It is responsive and will center the content on the screen
class ResponsiveRadioListTile extends StatelessWidget {
  const ResponsiveRadioListTile(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.title,
      this.onChanged});

  /// The title of the radio list tile
  final Widget title;
  /// The value of the radio list tile
  final String value;
  /// The current selected value among the radio list tiles
  final String groupValue;
  /// The function to call when the radio list tile is selected
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      child: RadioListTile.adaptive(
        title: title,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: theme.primaryColor,
      ),
    );
  }
}