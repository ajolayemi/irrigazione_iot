import 'package:flutter/material.dart';

class DashboardItemsListView<T> extends StatelessWidget {
  const DashboardItemsListView({
    super.key,
    required this.items,
    required this.itemBuilder,
  });

  final List<T> items;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: itemBuilder,
      itemCount: items.length,
    );
  }
}
