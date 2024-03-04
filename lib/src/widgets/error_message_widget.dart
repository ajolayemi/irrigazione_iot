import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

/// Reusable error message widget (just a [Text] with a red color).
class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget(this.errorMessage, {super.key});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: context.textTheme.titleLarge?.copyWith(color: Colors.red),
    );
  }
}
