import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_center.dart';

class CommonTabletResponsiveCenter extends StatelessWidget {
  const CommonTabletResponsiveCenter({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      padding: padding ?? const EdgeInsets.only(left: Sizes.p8),
      maxContentWidth: Breakpoint.tablet,
      child: child,
    );
  }
}
