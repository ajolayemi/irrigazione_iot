import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/empty_data_widget.dart';

class EmptyPumpWidget extends StatelessWidget {
  const EmptyPumpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;

    return SliverEmptyDataWidget(
      message: loc.emptyDataPlaceholder(loc.nPumps(1)),
      buttonText: loc.addNewButtonLabel,
      onPressed: () => context.pushNamed(
        AppRoute.addPump.name,
      ),
    );
  }
}