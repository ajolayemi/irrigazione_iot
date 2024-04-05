import 'package:flutter/material.dart';
import '../../../../constants/breakpoints.dart';
import '../../../../widgets/responsive_center.dart';

/// Useful for displaying items on the screen where user makes some selection
/// like selecting an irrigation system, irrigation source, etc.
/// It is responsive and will center the content on the screen
/// and will have a max width of 600 on tablet and desktop
/// The pages referencing this widget are mostly triggered by clicking on form fields
/// and the user makes a selection from the list of items to simulate a dropdown
class ResponsiveSelectScreensTile extends StatelessWidget {
  const ResponsiveSelectScreensTile({
    super.key,
    required this.title,
    this.onTap,
  });

  final VoidCallback? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Text(title),
        ),
      ),
    );
  }
}
