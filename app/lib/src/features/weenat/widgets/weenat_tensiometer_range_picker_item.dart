import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/theme/app_colors_palette.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class WeenatTensiometerRangePickerItem extends StatelessWidget {
  const WeenatTensiometerRangePickerItem({
    super.key,
    required this.label,
    this.onTap,
    this.decoration,
    this.labelColor,
    this.isClickable = true,
    this.padding,
  });
  final String label;
  final Color? labelColor;
  final Function(String?)? onTap;
  final Decoration? decoration;
  final bool isClickable;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return InkWell(
      onTap: isClickable ? () => onTap?.call(label) : null,
      child: Container(
        width: 40,
        padding: padding ?? const EdgeInsets.symmetric(
          horizontal: Sizes.p8,
          vertical: Sizes.p8,
        ),
        decoration: decoration,
        child: Text(
          label,
          textScaler: const TextScaler.linear(1) ,
          textAlign: TextAlign.center,
          style: textTheme.labelMedium?.copyWith(
            color: labelColor ?? AppColorsPalette.black,
          ),
        ),
      ),
    );
  }
}
