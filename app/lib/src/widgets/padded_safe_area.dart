import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

class PaddedSafeArea extends StatelessWidget {
  const PaddedSafeArea({super.key, required this.child, this.padding});

  final EdgeInsets? padding;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: Sizes.p8),
        child: child,
      ),
    );
  }
}
