import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/shared/widgets/empty_data_widget.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class EmptyBoardWidget extends ConsumerWidget {
  const EmptyBoardWidget({
    super.key,
    required this.onTapAdd,
    this.alternativeMessage,
  });

  final String? alternativeMessage;
  final VoidCallback onTapAdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return SliverFillRemaining(
      child: EmptyDataWidget(
          message:
              alternativeMessage ?? loc.emptyDataPlaceholder(loc.nBoards(1)),
          buttonText: loc.addNewButtonLabel,
          onPressed: onTapAdd),
    );
  }
}
