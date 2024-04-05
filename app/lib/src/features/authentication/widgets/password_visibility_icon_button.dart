import 'package:flutter/material.dart';

class PasswordVisibilityIconButton extends StatelessWidget {
  const PasswordVisibilityIconButton({
    super.key,
    this.onPressed,
    required this.isVisible,
  });

  final VoidCallback? onPressed;
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
      ),
      onPressed: onPressed,
    );
  }
}
