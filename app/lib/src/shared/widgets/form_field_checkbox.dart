import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class FormFieldCheckboxTile extends StatelessWidget {
  const FormFieldCheckboxTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium,
        ),
        Checkbox.adaptive(
          value: value,
          onChanged: onChanged,
          activeColor: theme.primaryColor,
        ),
      ],
    );
  }
}
