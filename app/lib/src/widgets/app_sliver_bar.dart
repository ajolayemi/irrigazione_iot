import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../utils/extensions.dart';

class AppSliverBar extends StatelessWidget {
  const AppSliverBar({
    super.key,
    required this.title,
    this.actions,
    this.expandedHeight,
  });

  final String title;
  final double? expandedHeight;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      floating: true,
      pinned: true,
      snap: true,
      expandedHeight: expandedHeight ?? 100.0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(
          vertical: Sizes.p8,
          horizontal: Sizes.p16,
        ),
        title: Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(
            color: Colors.black,
          ),
        ),
      ),
      actions: actions,
    );
  }
}