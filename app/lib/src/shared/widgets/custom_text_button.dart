import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

/// Custom text button with a fixed height
class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    this.style,
    this.onPressed,
  });
  final String text;
  final TextStyle? style;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: style ??
              TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: context.theme.primaryColor,
                decorationThickness: 2.0,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
