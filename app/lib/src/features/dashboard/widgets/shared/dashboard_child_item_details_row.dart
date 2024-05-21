import 'package:flutter/material.dart';

/// A [Row] widget that displays additional information
/// about an item on the dashboard screen. Such info maybe
/// the last time a pump was switched on or off, it's current
/// flow rate, etc.
class DashboardChildItemDetailsRow extends StatelessWidget {
  const DashboardChildItemDetailsRow({
    super.key,
    required this.leading,
    required this.trailing,
  });

  final Widget leading;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: leading),
        Flexible(child: trailing),
      ],
    );
  }
}
