import 'package:flutter/material.dart';
import '../../../../widgets/common_skeleton_tile.dart';

// * A custom sliver list skeleton for skeletonizer to use when loading data for pump details screen
class PumpDetailsSliverListSkeleton extends StatelessWidget {
  const PumpDetailsSliverListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return CommonSkeletonTile(
            hasLeading: false,
            hasTrailing: index == 0,
          );
        },
        childCount: 5,
      ),
    );
  }
}
