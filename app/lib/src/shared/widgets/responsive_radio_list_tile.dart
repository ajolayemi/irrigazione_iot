import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_center.dart';

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
  final String title;

  /// The value of the radio list tile
  final RadioButtonItem value;

  /// The current selected value among the radio list tiles
  final RadioButtonItem groupValue;

  /// The function to call when the radio list tile is selected
  final void Function(RadioButtonItem?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      child: RadioListTile.adaptive(
        title: Text(title),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: theme.primaryColor,
      ),
    );
  }
}
