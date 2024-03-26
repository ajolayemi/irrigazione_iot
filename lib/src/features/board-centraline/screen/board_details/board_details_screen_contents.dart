import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/widgets/responsive_details_card.dart';

class BoardDetailsScreenContents extends ConsumerWidget {
  const BoardDetailsScreenContents({
    super.key,
    required this.board,
  });

  final Board board;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return SliverList(
        delegate: SliverChildListDelegate.fixed([
      ResponsiveDetailsCard(
        child: DetailTileWidget(
          title: loc.boardModel,
          subtitle: board.model,
        ),
      ),
      ResponsiveDetailsCard(
        child: DetailTileWidget(
          title: loc.boardSerialNumber,
          subtitle: board.serialNumber,
        ),
      ),
      ResponsiveDetailsCard(child: Consumer(
        builder: (context, ref, child) {
          final collector =
              ref.watch(collectorStreamProvider(board.collectorId)).valueOrNull;
          return DetailTileWidget(
            title: loc.boardConnectedCollector,
            subtitle: collector?.name,
          );
        },
      ))
    ]));
  }
}
