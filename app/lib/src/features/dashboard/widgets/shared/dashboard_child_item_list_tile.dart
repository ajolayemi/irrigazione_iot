import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';

/// A [ListTile] widget wrapped with a card useful
/// for displaying the list of items in the dashboard.
///
/// Items could be the list of pumps switched on and so on
class DashboardChildItemListTile extends StatelessWidget {
  const DashboardChildItemListTile(
      {super.key, this.title, this.trailing, this.subtitle});

  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.p16),
      child: 
        ListTile(
          title: title,
          subtitle: subtitle,
          trailing: trailing,
        ),
      
    );
  }
}
