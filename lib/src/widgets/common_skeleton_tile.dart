import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

// * A custom skeleton tile for skeletonizer to use when loading data
class CommonSkeletonTile extends StatelessWidget {
  const CommonSkeletonTile({
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
    return Skeletonizer.bones(
      child: ListTile(
        leading: hasLeading ? const Bone.circle(size: 48) : null,
        title: hasTitle ? const Bone.text(words: 2) : null,
        subtitle: hasSubtitle ? const Bone.text() : null,
        trailing: hasTrailing ? const Bone.icon() : null,
      ),
    );
  }
}
