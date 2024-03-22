import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

/// A common widget to display a radio list tile with a label
/// It is responsive and will center the content on the screen
class ResponsiveRadioListTile extends StatelessWidget {
  const ResponsiveRadioListTile(
      {super.key,
      required this.value,
      required this.groupValue,
      this.onChanged});

  final String value;
  final String groupValue;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      child: RadioListTile.adaptive(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: theme.primaryColor,
      ),
    );
  }
}
