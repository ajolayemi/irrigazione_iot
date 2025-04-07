import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';

class PaddedSafeArea extends StatelessWidget {
  const PaddedSafeArea({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: Sizes.p8),
    required this.child,
  });

  final EdgeInsets padding;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: padding,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: child,
        ),
      ),
    );
  }
}
