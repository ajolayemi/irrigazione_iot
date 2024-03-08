import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/custom_text_button.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

/// A place holder widget to tell user that there is no data to show.
/// It presents a text button to allow user to perform a specific action.
class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    super.key,
    required this.message,
    required this.buttonText,
    required this.onPressed,
  });

  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          CustomTextButton(
            text: buttonText,
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
