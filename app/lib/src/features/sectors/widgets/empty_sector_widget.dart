import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_data_widget.dart';

class EmptySectorWidget extends StatelessWidget {
  const EmptySectorWidget({
    super.key,
    this.alternativeMessage,
  });

  final String? alternativeMessage;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return SliverFillRemaining(
      child: EmptyDataWidget(
        message:
            alternativeMessage ?? loc.emptyDataPlaceholder(loc.nSectors(1)),
        buttonText: loc.addNewButtonLabel,
        onPressed: () => context.pushNamed(AppRoute.addSector.name),
      ),
    );
  }
}
