import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/dashboard/data/dashboard_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

/// Widget to display the list of pumps switched on in the dashboard if there
/// are any.
class PumpsSwitchedOnList extends ConsumerStatefulWidget {
  const PumpsSwitchedOnList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PumpsSwitchedOnListState();
}

class _PumpsSwitchedOnListState extends ConsumerState<PumpsSwitchedOnList> {
  @override
  Widget build(BuildContext context) {
    // final pumps = ref.watch(pumpsStatusesStatsStreamProvider).valueOrNull;
    // if (pumps != null && pumps.isNotEmpty) {
    //   final first = pumps.first;
    //   final da = DateTime.now()
    //       .subtract(Duration(seconds: first.totalDurationInSeconds));
    //   print(da.toLocal());
    //   print(context.timeAgo(da));
    // }
    return Container();
  }
}
