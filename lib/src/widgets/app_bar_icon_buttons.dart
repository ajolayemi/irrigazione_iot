import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.isVisibile = true,
  });

  final VoidCallback onPressed;
  final bool? isVisibile;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisibile ?? true,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 30,
        ),
      ),
    );
  }
}
