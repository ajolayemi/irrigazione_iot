import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/no_glow_scroll_behaviour.dart';

class NoGlowScroll extends StatelessWidget {
  final Widget child;

  const NoGlowScroll({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: child,
    );
  }
}