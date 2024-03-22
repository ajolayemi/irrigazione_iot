import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';

class BoardDetailsScreenContents extends ConsumerWidget {
  const BoardDetailsScreenContents({
    super.key,
    required this.board,
  });

  final Board board;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(delegate: SliverChildListDelegate.fixed([
      
    ]));
  }
}
