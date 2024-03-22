import 'package:flutter/material.dart';

class CommonFormSuffixIcon extends StatelessWidget {
  const CommonFormSuffixIcon({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_drop_down),
    );
  }
}
