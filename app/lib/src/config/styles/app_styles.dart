import 'package:flutter/material.dart';

extension AppCommonStyles on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle? get titleSmall => textTheme.titleSmall;

  TextStyle? get commonSubtitleStyle =>
      titleSmall?.copyWith(color: Colors.grey);
}
