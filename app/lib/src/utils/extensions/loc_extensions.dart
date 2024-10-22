import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

extension LocExtensions on BuildContext {
  String getLocByKey(String key) {
    final loc = this.loc;
    switch (key) {
      case 'weenatLast7Days':
        return loc.weenatLast7Days;
      case 'weenatLast24Hours':
        return loc.weenatLast24Hours;
      case 'weenatLastHour':
        return loc.weenatLastHour;
      default:
        return '';
    }
  }
}
