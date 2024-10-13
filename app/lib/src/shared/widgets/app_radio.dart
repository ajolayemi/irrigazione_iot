import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/theme/app_colors_palette.dart';

class AppRadio extends StatelessWidget {
  const AppRadio({
    super.key,
    required this.value,
    this.groupValue,
    required this.onChanged,
  });

  final String value;
  final String? groupValue;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Radio(
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          return AppColorsPalette.grey8;
        },
      ),
    );
  }
}
