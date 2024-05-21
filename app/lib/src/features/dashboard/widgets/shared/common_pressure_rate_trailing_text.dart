import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/utils/extensions/double_extensions.dart';

class CommonPressureRateTrailingText extends StatelessWidget {
  const CommonPressureRateTrailingText({
    super.key,
    required this.pressure,
  });

  final double pressure;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Text(
      '${pressure.toStringAsFixed(2)} bar',
      style: textTheme.titleMedium?.copyWith(
        color: pressure.getPressureColor(),
      ),
    );
  }
}
