import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';

class PaddedSafeArea extends StatelessWidget {
  const PaddedSafeArea({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: Sizes.p8),
  });

  final EdgeInsets padding;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
