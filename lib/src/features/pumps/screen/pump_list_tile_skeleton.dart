import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/widgets/sliver_skeleton_tile.dart';

class PumpListTileSkeleton extends StatelessWidget {
  const PumpListTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        return const CustomSkeletonTile(
          hasLeading: false,
        );
      },
      childCount: 6,
    ));
  }
}
