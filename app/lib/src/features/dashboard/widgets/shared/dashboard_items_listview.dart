import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_responsive_divider.dart';

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
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const CommonResponsiveDivider();
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: itemBuilder,
      itemCount: items.length,
    );
  }
}
