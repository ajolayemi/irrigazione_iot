import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board.dart';

class BoardDetailsScreen extends ConsumerWidget {
  const BoardDetailsScreen({
    super.key,
    required this.boardID,
  });

  final BoardID boardID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
