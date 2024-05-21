import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/dashboard/widgets/shared/dashboard_child_item_details_row.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

/// Simple widget to display last time that a pump flow was received.
class PumpFlowLastUpdated extends ConsumerWidget {
  const PumpFlowLastUpdated({super.key, required this.pumpId});

  final String pumpId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastPumpFlow =
        ref.watch(pumpLastFlowStreamProvider(pumpId)).valueOrNull?.createdAt;

    if (lastPumpFlow == null) return const PumpFlowLastUpdatedContent();
    return Timeago(
      builder: (_, value) {
        return PumpFlowLastUpdatedContent(content: value);
      },
      date: lastPumpFlow,
      locale: context.locale,
    );
  }
}

class PumpFlowLastUpdatedContent extends StatelessWidget {
  const PumpFlowLastUpdatedContent({super.key, this.content});

  final String? content;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return DashboardChildItemDetailsRow(
      leading: Text(loc.lastUpdated),
      trailing: Text(content ?? loc.notAvailable),
    );
  }
}
