import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  Size get screenSize => MediaQuery.of(this).size;

  AppLocalizations get loc => AppLocalizations.of(this);
}

extension StringExtensions on String {
  /// Returns true if the string is a number and is greater than 0
  /// Mostly used for validating form fields
  bool get isGreaterThanZero =>
      double.tryParse(this) != null && double.parse(this) > 0;

  // todo: remove this
  /// Returns true if the string is a number and is greater than 0
  /// Mostly used for validating form fields
  bool valueIsGreaterThanZero() {
    return double.tryParse(this) != null && double.parse(this) > 0;
  }
}
