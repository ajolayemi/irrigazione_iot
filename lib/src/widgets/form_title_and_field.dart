import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class FormTitleAndField extends StatelessWidget {
  const FormTitleAndField({
    super.key,
    required this.fieldKey,
    required this.fieldTitle,
    this.fieldController,
    this.fieldHintText,
    this.autovalidateMode,
    this.autoCorrect,
    this.keyboardType,
    this.keyboardAppearance,
    this.onEditingComplete,
    this.inputFormatters,
    this.validator,
    this.textInputAction,
    this.obscureText,
    this.enabled,
    this.maxLines,
    this.suffixIcon,
    this.onTap,
    this.canRequestFocus
  });

  final Key fieldKey;
  final String fieldTitle;
  final TextEditingController? fieldController;
  final String? fieldHintText;
  final AutovalidateMode? autovalidateMode;
  final bool? autoCorrect;
  final TextInputType? keyboardType;
  final Brightness? keyboardAppearance;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final bool? obscureText;
  final bool? enabled;
  final Widget? suffixIcon;
  final bool? canRequestFocus;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldTitle,
          style: context.textTheme.titleSmall,
        ),
        gapH8,
        TextFormField(
          key: fieldKey,
          controller: fieldController,
          onTap: onTap,
          canRequestFocus: canRequestFocus ?? true,
          //maxLines: maxLines,
          decoration: InputDecoration(
            hintText: fieldHintText,
            errorMaxLines: 3,
            enabled: enabled ?? true,
            suffixIcon: suffixIcon,
          ),
          autovalidateMode:
              autovalidateMode ?? AutovalidateMode.onUserInteraction,
          validator: validator,
          autocorrect: autoCorrect ?? false,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          keyboardAppearance: keyboardAppearance ?? Brightness.light,
          onEditingComplete: onEditingComplete,
          inputFormatters: inputFormatters,
          obscureText: obscureText ?? false,
        ),
      ],
    );
  }
}
