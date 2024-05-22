import 'package:flutter/material.dart';

extension PressureColorX on double {
  /// Returns the color that represents a pressure level.
  Color? getPressureColor() {
    if (this < 3.5) {
      return Colors.green;
    } else if (this < 4.0) {
      return Colors.yellow[600];
    }
    return Colors.red;
  }
}
