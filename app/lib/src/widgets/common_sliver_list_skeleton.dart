// todo: this should replace all other skeletons in the app
import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/widgets/common_skeleton_tile.dart';

/// A sliver version of the [CommonSkeletonTile]
class CommonSliverListSkeleton extends StatelessWidget {
  const CommonSliverListSkeleton({
    super.key,
    this.hasLeading = true,
    this.hasTrailing = true,
    this.hasSubtitle = true,
    this.hasTitle = true,
  });

  final bool hasLeading;
  final bool hasTrailing;
  final bool hasSubtitle;
  final bool hasTitle;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        return CommonSkeletonTile(
          hasLeading: hasLeading,
          hasSubtitle: hasSubtitle,
          hasTitle: hasTitle,
          hasTrailing: hasTrailing,
        );
      },
      childCount: 10,
    ));
  }
}
