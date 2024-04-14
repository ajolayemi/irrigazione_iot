import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

/// A common widget to display a checkbox with a label
/// It is responsive and will center the content on the screen
class ResponsiveCheckboxTile extends StatelessWidget {
  const ResponsiveCheckboxTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final void Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      child: CheckboxListTile.adaptive(
        value: value,
        onChanged: onChanged,
        title: Text(title),
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: theme.primaryColor,
      ),
    );
  }
}
