import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_center.dart';

class CommonTabletResponsiveCenter extends StatelessWidget {
  const CommonTabletResponsiveCenter({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      child: child,
    );
  }
}
