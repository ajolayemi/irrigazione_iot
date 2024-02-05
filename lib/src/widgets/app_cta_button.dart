import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

/// Call To Action button based on [ElevatedButton] or [OutlinedButton] base on
/// whether it's a primary or secondary button..
class CTAButton extends StatelessWidget {
  /// Create a CTAButton.
  /// if [isLoading] is true, a loading indicator will be displayed instead of
  /// the text.
  const CTAButton({
    super.key,
    required this.text,
    required this.buttonType,
    this.isLoading = false,
    this.onPressed,
  });
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    final content = isLoading
        ? const CircularProgressIndicator()
        : Text(
            text,
            textAlign: TextAlign.center,
            style: context.textTheme.titleLarge!.copyWith(
              color: buttonType == ButtonType.primary
                  ? Colors.white
                  : context.theme.primaryColor,
            ),
          );
    return SizedBox(
      height: Sizes.p48,
      child: buttonType == ButtonType.primary
          ? ElevatedButton(onPressed: onPressed, child: content)
          : OutlinedButton(
              onPressed: onPressed,
              child: content,
            ),
    );
  }
}
