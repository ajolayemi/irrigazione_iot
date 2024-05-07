import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_data_widget.dart';

class EmptyCollectorWidget extends ConsumerWidget {
  const EmptyCollectorWidget({
    super.key,
    this.onPressed,
    this.alternativeMessage,
  });

  final VoidCallback? onPressed;
  final String? alternativeMessage;

  void _onPressed({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    ref.read(selectedSectorsIdProvider.notifier).state = [];
    context.pushNamed(
      AppRoute.addCollector.name,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return SliverFillRemaining(
      child: EmptyDataWidget(
          message: alternativeMessage ??
              loc.emptyDataPlaceholder(loc.nCollectors(1)),
          buttonText: loc.addNewButtonLabel,
          onPressed: onPressed ?? () => _onPressed(context: context, ref: ref)),
    );
  }
}
