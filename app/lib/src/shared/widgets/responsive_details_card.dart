// * Card to display details of items like pumps, sectors etc
import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_center.dart';

class ResponsiveDetailsCard extends StatelessWidget {
  const ResponsiveDetailsCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p8,
        vertical: Sizes.p4,
      ),
      child: Card(
        elevation: 2,
        surfaceTintColor: Colors.transparent.withOpacity(0.2),
        child: child,
      ),
    );
  }
}
