import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

class ResponsiveListTile extends StatelessWidget {
  const ResponsiveListTile({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        child: ListTile(
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          onTap: onTap,
        ));
  }
}
