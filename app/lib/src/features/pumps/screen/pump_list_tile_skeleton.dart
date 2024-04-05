import 'package:flutter/material.dart';
import '../../../widgets/common_skeleton_tile.dart';

class PumpListTileSkeleton extends StatelessWidget {
  const PumpListTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        return const CommonSkeletonTile(
          hasLeading: false,
        );
      },
      childCount: 6,
    ));
  }
}