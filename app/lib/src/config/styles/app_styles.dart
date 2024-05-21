import 'package:flutter/material.dart';

extension AppCommonStyles on BuildContext {
  TextTheme get _textTheme => Theme.of(this).textTheme;

  TextStyle? get titleSmall => _textTheme.titleSmall;

  TextStyle? get commonSubtitleStyle =>
      titleSmall?.copyWith(color: Colors.grey);
}
