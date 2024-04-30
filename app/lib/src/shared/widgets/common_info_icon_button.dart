import 'package:flutter/material.dart';

class CommonInfoIconButton extends StatelessWidget {
  const CommonInfoIconButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info_outline),
      onPressed: onPressed,
    );
  }
}
