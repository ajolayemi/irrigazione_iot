import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/empty_data_widget.dart';

class EmptyCollectorWidget extends StatelessWidget {
  const EmptyCollectorWidget({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return SliverFillRemaining(
      child: EmptyDataWidget(
        message: loc.emptyDataPlaceholder(loc.nCollectors(1)),
        buttonText: loc.addNewButtonLabel,
        onPressed: onPressed,
      ),
    );
  }
}
