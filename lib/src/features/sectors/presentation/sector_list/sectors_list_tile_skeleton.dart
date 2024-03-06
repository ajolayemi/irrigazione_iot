import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/widgets/sliver_skeleton_tile.dart';

// todo check if the skeleton can be refactored to be used in other places
class SectorsListTileSkeleton extends StatelessWidget {
  const SectorsListTileSkeleton({super.key});

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

class SectorsListTileSkeletonNonSliver extends StatelessWidget {
  const SectorsListTileSkeletonNonSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return const CustomSkeletonTile(
          hasLeading: false,
        );
      },
    );
  }
}
